import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moives_app/providers/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:moives_app/screens/moviesOverview_screen.dart';

enum AuthMode { Signup, Login }
class AuthForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm>  with SingleTickerProviderStateMixin{
  
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> opacityuAnimation;
  final TextEditingController controller = TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    'phone': '',
  };

  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    opacityuAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    emailFocusNode.dispose();
    _controller.dispose();
    // controller.dispose();

    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(message),
              actions: [
                FlatButton(
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).singin(
          _authData['email'] as String,
          _authData['password'] as String,
          _authData['name'] as String,
          _authData['phone'] as String,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).singup(
          _authData['email'] as String,
          _authData['password'] as String,
          _authData['name'] as String,
          _authData['phone'] as String,
        );
      }
      Navigator.of(context)
          .pushReplacementNamed(MoviesOverviewScreen.routeName);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate you.please try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  var currentFocus;
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  String initialCountry = 'eg';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'EG');

    setState(() {
      this.number = number;
    });
  }
 



  @override
  Widget build(BuildContext context) {
  //    File? _image;
  //     Future getImage() async {
  //  final ImagePicker _picker = ImagePicker();
  //   final  pickedImageFile = await _picker.pickImage(
  //       source: ImageSource.camera);

  //     setState(() {
  //       _image = pickedImageFile as File;
  //         print('Image Path $_image');
  //     });
  //   }
    final deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: Container(
        height: _authMode == AuthMode.Signup ? 700 : 350,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 700 : 350),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: FlatButton(
                      onPressed: () {
                        setState(() {
                          TextStyle(
                            decoration: TextDecoration.underline,
                          );
                          _authMode = AuthMode.Signup;
                        });
                      },
                      child: Text('SIGN UP'),
                    )),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _authMode = AuthMode.Login;
                        });
                      },
                      child: Text('LOGIN'),
                    )
                  ],
                ),
                // if (_authMode == AuthMode.Signup)
                //   Column(
                //     children: [
                //       CircleAvatar(
                //         maxRadius: 40,
                //         child: ClipOval(
                //           child: new SizedBox(
                //             width: 300.0,
                //             height: 300.0,
                //             child: (_image != null)
                //                 ? Image.file(
                //                     _image!,
                //                     fit: BoxFit.fill,
                //                   )
                //                 : Image.network(
                //                     "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                //                     fit: BoxFit.fill,
                //                   ),
                //           ),
                //         ),
                //       ),

                //         NetworkImage(
                //             'https://pbs.twimg.com/media/Ew7wqxjWEAYX7Db.jpg'),
                //       ),

                //       FlatButton.icon(
                //         onPressed: getImage,
                //         icon: Icon(Icons.camera_alt),
                //         label: Text('Pick Your Pic'),
                //       )
                //     ],
                //   ),
                if (_authMode == AuthMode.Signup)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          key: ValueKey('name'),
                          decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintStyle: TextStyle(color: Colors.white)),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(phoneFocusNode);
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Enter Your Name'
                              : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                      .hasMatch(value)
                                  ? 'Enter a Valid Name'
                                  : null,
                          onSaved: (value) {
                            _authData['name'] = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                if (_authMode == AuthMode.Signup)
                  Row(
                    children: [
                      Expanded(
                      
                        child: InternationalPhoneNumberInput(
                          selectorButtonOnErrorPadding: 50,
                          selectorTextStyle: TextStyle(color: Colors.black,fontSize: 15),
                          spaceBetweenSelectorAndTextField: 1,
                          hintText: "PhoneNumber",
                          key: ValueKey('phone'),
                          onInputChanged: (number) {
                            print(number.phoneNumber);
                          },
                          validator: (value) {
                            String pattern = r'(^(?:[+0]9)?[1-9]{10,12}$)';
                            RegExp regExp = new RegExp(pattern);

                            if (value!.length == 0) {
                              return 'Please enter mobile number';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid mobile number';
                            }
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            setSelectorButtonAsPrefixIcon: true,
                            leadingPadding: 20,
                            useEmoji: true,
                          ),
                          autoValidateMode: AutovalidateMode.disabled,
                          keyboardAction: TextInputAction.next,
                          
                          initialValue: number,
                          textFieldController: controller,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusNode: phoneFocusNode,
                          onSaved: (value) {
                            _authData['phone'] = value.toString();
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(emailFocusNode);
                          },
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _emailController,
                        key: ValueKey('email'),
                        decoration: InputDecoration(
                          labelText: 'E-Mail',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: emailFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: ValueKey('password'),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        textInputAction: _authMode == AuthMode.Login
                            ? TextInputAction.done
                            : TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(confirmPasswordFocusNode);
                        },
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'invalid Password ';
                          } else if (value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value!;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (_authMode == AuthMode.Signup)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          focusNode: confirmPasswordFocusNode,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                }
                              : null,
                        ),
                      )
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button!.color,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
