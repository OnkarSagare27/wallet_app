import 'package:flutter/material.dart';

// Custom gradient button
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.text});
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: false,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF0C300),
              Color.fromARGB(255, 191, 166, 25),
              Color(0xFFF0C300),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
