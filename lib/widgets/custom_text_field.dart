import 'package:flutter/material.dart';

// A custom text field widget
class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.enabled,
      this.controller,
      this.errorText,
      this.hintText,
      this.suffixIcon,
      this.obscureText = false});
  final bool? enabled;
  final bool obscureText;
  final TextEditingController? controller;
  final String? errorText;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        filled: true,
        fillColor: const Color(0xff212121),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            )),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
