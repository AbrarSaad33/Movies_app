import 'package:flutter/material.dart';

Widget customTextField(
        {Key? key,
        required String hintText,
        required TextInputType keyboardType,
        required TextInputAction textInputAction,
        FormFieldSetter<String>? onSaved,
        ValueChanged<String>? onFieldSubmitted,
        FormFieldValidator<String>? validator,
        required IconData icon,
        required FocusNode focusNode,
        TextEditingController? controller,
        bool isSecure = false,
        bool? enabled}) =>
    TextFormField(
      controller: controller,
        key: key,
        obscureText: isSecure,
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintStyle: TextStyle(color: Colors.white)),
        style: TextStyle(color: Colors.black54),
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        focusNode: focusNode);
