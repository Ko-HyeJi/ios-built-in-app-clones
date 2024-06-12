import 'package:flutter/material.dart';

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
      turns: AlwaysStoppedAnimation((360 - rotationAngle) / 360),
      child: child,
    );
  }
}
