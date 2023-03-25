import 'package:flutter/material.dart';

Widget defaultForm(
        {required TextEditingController controler,
        bool obscureText = false,
        required TextInputAction textInputAction,
        Widget? suffixIcon,
        Widget? suffix,
        Icon? prefixIcon,
        String? labels,
        TextInputType? type,
        required Function? validator,
        Function(dynamic)? onFieldSubmitted}) =>
    TextFormField(
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(),
          labelText: labels),
      controller: controler,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validator!(value);
        }
        return null;
      },
    );
Widget defaultSubmit({required String text, required Function() onPressed}) =>
    Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      // decoration: BoxDecoration(color: Colors.blue),
      width: double.infinity,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
