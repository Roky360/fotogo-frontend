import 'package:flutter/material.dart';

Widget fotogoTextButton({
  required onPressed,
  required Widget child
}) {
  return TextButton(
    onPressed: onPressed,
    child: child,
    style: ButtonStyle(
      // color
    ),
  );
}
