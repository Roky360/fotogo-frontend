import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fotogo/utils/screen_manipulation.dart';
import 'package:fotogo/widgets/app_widgets.dart';

Widget albumCover(BuildContext context) {
  return Container(
    width: context.getPixelCountFromScreenPercentage(width: 90).width,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(15)
    ),

  );
}
