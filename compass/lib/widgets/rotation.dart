import 'package:flutter/material.dart';
import 'package:compass/main.dart';

class Rotation extends StatelessWidget {
  const Rotation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(rotationAngle / 360),
      child: child,
    );
  }
}
