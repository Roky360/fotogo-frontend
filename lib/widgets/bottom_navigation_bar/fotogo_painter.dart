import 'package:flutter/material.dart';

class FotogoBNBPainter extends CustomPainter {
  late BuildContext _context;
  late Color _backgroundColor;

  FotogoBNBPainter(
    context, {
    required Color backgroundColor,
  }) {
    _context = context;
    _backgroundColor = backgroundColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double radius = height * .3;
    double rightMiddleEdge = width * .41;

    // Define the brush
    var paint = Paint();
    paint.color = _backgroundColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    // Path drawing
    // Left side
    var path = Path();
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

    Offset shadowOffset = const Offset(0, -5);
    Color shadowColor =
        Theme.of(_context).colorScheme.onPrimary.withOpacity(.5);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 5, true);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 10, true);
    canvas.drawShadow(path.shift(shadowOffset), shadowColor, 15, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
