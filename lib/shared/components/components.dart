import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
// Widget defaultSubmit({required String text, required Function() onPressed}) =>
//     Container(
//       padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
//       // decoration: BoxDecoration(color: Colors.blue),
//       width: double.infinity,
//       child: MaterialButton(
//         color: Colors.blue,
//         onPressed: onPressed,
//         child: Text(text),
//       ),
//     );
Widget defaultSubmit({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  Function()? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
      ),
    );

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
