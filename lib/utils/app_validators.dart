import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppValidations {
  static void showSnackBar(BuildContext? context, String? value) {
    final snackBar = SnackBar(content: Text(value!));
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg.trim(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
