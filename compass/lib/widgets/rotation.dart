import 'package:flutter/material.dart';
import 'package:compass/main.dart';

class Rotation extends StatelessWidget {
  const Rotation({
    super.key,
    required this.child,
    required this.rotationAngle,
  });

  final Widget child;
  final double rotationAngle;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(rotationAngle / 360),
      child: child,
    );
  }
}
