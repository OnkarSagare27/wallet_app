import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  // Create a SnackBar
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  );

  // Show the SnackBar using ScaffoldMessenger
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
