import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderRadius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;
  final EdgeInsets padding;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.borderColor = AppColors.dashedBorder,
    this.borderRadius = 16,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.strokeWidth = 1.5,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: borderColor,
        borderRadius: borderRadius,
        dashWidth: dashWidth,
        dashGap: dashGap,
        strokeWidth: strokeWidth,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final dashPath = _createDashedPath(path);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source) {
    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0, metric.length).toDouble();
        dashedPath.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += dashWidth + dashGap;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return color != oldDelegate.color ||
        borderRadius != oldDelegate.borderRadius ||
        dashWidth != oldDelegate.dashWidth ||
        dashGap != oldDelegate.dashGap ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
