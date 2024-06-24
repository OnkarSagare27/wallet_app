import 'package:flutter/material.dart';

// A custom widget to create a floating icon with shadow and golden border on the create wallet screen
class RectangularImageWithShadowBorder extends StatelessWidget {
  final String imagePath;

  const RectangularImageWithShadowBorder({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.amber,
          width: 5.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
