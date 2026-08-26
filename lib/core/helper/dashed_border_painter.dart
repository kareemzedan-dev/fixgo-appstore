/// dashed_border_painter.dart
library;

import 'package:flutter/material.dart';

class DashedBorderPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    const strokeWidth = 1.2;

    final paint = Paint()
      ..color = const Color(
        0xFF737373,
      )
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(16),
    );

    final path = Path()
      ..addRRect(rrect);

    for (final metric
        in path.computeMetrics()) {
      double distance = 0;

      while (distance <
          metric.length) {
        final extractPath = metric.extractPath(
          distance,
          distance + dashWidth,
        );

        canvas.drawPath(
          extractPath,
          paint,
        );

        distance +=
            dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) {
    return false;
  }
}