import 'package:flutter/material.dart';

Size textSize(
    {required String text,
    required TextStyle style,
    TextDirection textDirection = TextDirection.ltr}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: textDirection)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
