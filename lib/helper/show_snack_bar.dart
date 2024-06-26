import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
