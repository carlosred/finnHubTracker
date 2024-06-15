import 'package:flutter/material.dart';

class Toast {
  static void showToast(
      {required BuildContext context, required String message}) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
      duration: const Duration(
        seconds: 3,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
