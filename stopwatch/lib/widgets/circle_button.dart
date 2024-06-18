import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.onTap,
    required this.size,
    required this.color,
    required this.text,
    required this.textColor,
  });

  final GestureTapCallback onTap;
  final double size;
  final Color color;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: size * 0.2, fontWeight: FontWeight.w500,),
          ),
        ),
      ),
    );
  }
}
