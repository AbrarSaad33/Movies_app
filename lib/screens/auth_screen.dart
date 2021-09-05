import 'package:flutter/material.dart';
import 'package:moives_app/widgets/auth_form.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: new GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    // final auth = FirebaseAuth.instance;
    // var isLoading = false;
    // @override
    // void setState(fn) {
    //   if (mounted) {
    //     super.setState(fn);
    //   }
    // }

    // void submit(String email, String password, String name, File? image,
    //     bool isLogin, BuildContext ctx) async {
    //   UserCredential userCredential;
    //   try {
    //     setState(() {
    //       isLoading = true;
    //     });
    //     if (isLogin) {
    //       userCredential = await auth.signInWithEmailAndPassword(
    //           email: email, password: password);
    //     } else {
    //       userCredential = await auth.createUserWithEmailAndPassword(
    //           email: email, password: password);

    //       final ref = FirebaseStorage.instance
    //           .ref()
    //           .child('user_image')
    //           .child(userCredential.user!.uid + '.jpg');
    //       if (image != null) await ref.putFile(image);

    //       final url = await ref.getDownloadURL();

    //       await FirebaseFirestore.instance
    //           .collection('users')
    //           .doc(userCredential.user!.uid)
    //           .set({'username': name, 'email': email, 'image_url': url});
    //     }
    //   } on PlatformException catch (error) {
    //     var message = 'An error occurred,please check your credentials';
    //     if (error.message != null) {
    //       message = error.message!;
    //     }
    //     Scaffold.of(ctx).showSnackBar(SnackBar(
    //       content: Text(message),
    //       backgroundColor: Theme.of(ctx).errorColor,
    //     ));
    //     setState(() {
    //       isLoading = false;
    //     });
    //   } catch (error) {
    //     print(error);
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }

    return AuthForm();
  }
}
