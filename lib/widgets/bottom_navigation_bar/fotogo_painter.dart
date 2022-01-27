import 'package:flutter/material.dart';

class FotogoBNBPainter extends CustomPainter {
  late BuildContext context;
  late PaintingStyle _paintingStyle;
  late double borderRadius;

  FotogoBNBPainter(this.context, {required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    // Define the brush
    var paint = Paint();
    paint.color = Theme.of(context).colorScheme.onPrimary;
    paint.style = PaintingStyle.fill;

    // Path painting
    var path = Path();
    paintBNB(path, size, borderRadius);

    // Stroke painting
    // paint.style = PaintingStyle.stroke;
    // paint.strokeWidth = 2;
    // paint.color = Theme.of(_context).colorScheme.primary;
    // paintBNB(path, size);

    // Shadow
    Offset shadowOffset = const Offset(0, -5);
    Color shadowColor =
        Theme.of(context).colorScheme.onPrimary.withOpacity(.5);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 5, true);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 10, true);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 15, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void paintBNB(Path path, Size size, double radius) {
    double width = size.width;
    double height = size.height;
    double rightMiddleEdge = width * .41;

    // Left side
    path.moveTo(0, radius);
    path.lineTo(0, height - radius);
    path.quadraticBezierTo(0, height, radius, height);
    path.lineTo(rightMiddleEdge, height);
    path.cubicTo(rightMiddleEdge - width * .062, height * .75,
        rightMiddleEdge - width * .062, height * .25, rightMiddleEdge, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);

    // Right side
    path.moveTo(width, radius);
    path.lineTo(width, height - radius);
    path.quadraticBezierTo(width, height, width - radius, height);
    path.lineTo(width - rightMiddleEdge, height);
    path.cubicTo(
        width - (rightMiddleEdge - width * .062),
        height * .75,
        width - (rightMiddleEdge - width * .062),
        height * .25,
        width - rightMiddleEdge,
        0);
    path.lineTo(width - radius, 0);
    path.quadraticBezierTo(width, 0, width, radius);
  }
}
