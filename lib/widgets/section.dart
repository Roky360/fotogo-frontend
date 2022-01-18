import 'package:flutter/material.dart';
import 'package:fotogo/theme/style.dart';

Widget section({
  required String title,
  required Widget body,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: themeData.textTheme.headline1,),
          SizedBox(height: 20,),
          body
        ],
      ),
    ),
  );
}

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
