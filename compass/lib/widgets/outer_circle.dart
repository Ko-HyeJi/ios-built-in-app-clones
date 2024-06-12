import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:compass/color+.dart';

import '../main.dart';

// class OuterCircle extends StatelessWidget {
//   const OuterCircle({
//     super.key,
//   });
//
//   static const _thin = [0.9142857143, 0.9142857143 * 4];
//   static const _thick = [2.5, 61.5];
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 245,
//           width: 245,
//           child: DottedBorder(
//             borderType: BorderType.Circle,
//             strokeWidth: 17.5,
//             color: CustomColors.white,
//             dashPattern: _thin,
//             child: const ClipRRect(),
//           ),
//         ),
//         SizedBox(
//           height: 245,
//           width: 245,
//           child: DottedBorder(
//             borderType: BorderType.Circle,
//             strokeWidth: 17.5,
//             color: CustomColors.white,
//             dashPattern: _thick,
//             child: const ClipRRect(),
//           ),
//         ),
//         Transform.translate(
//           offset: const Offset(
//             118,
//             -28,
//           ),
//           child: const Image(
//             image: AssetImage('assets/arrowtriangle.png'),
//             height: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

class OuterCircleByCustomPainter extends StatelessWidget {
  const OuterCircleByCustomPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Rotation(
      rotationAngle: 15,
      child: Stack(
        children: [
          for (var i = 0; i < 180; i++)
            Rotation(
              rotationAngle: i * 2,
              child: CustomPaint(
                size: const Size(180, 180),
                painter: MarkPainter(strokeWidth: i % 15 == 0 ? 2.5 : 1.0),
              ),
            ),
        ],
      ),
    );
  }
}

class MarkPainter extends CustomPainter {
  final double strokeWidth;

  MarkPainter({
    super.repaint,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const lineLength = 12;

    Paint paint = Paint()
      ..color = CustomColors.white
      ..strokeWidth = strokeWidth
      ..blendMode = myBlendMode;

    Offset p1 = Offset(size.width - lineLength, size.height - lineLength);
    Offset p2 = Offset(size.width, size.height);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.red
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return false;
  }
}
