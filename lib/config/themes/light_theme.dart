import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  // TODO: what to do with multiple (accent) colors?
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF013250),
    onPrimary: Color(0xffdef2ff),
    // onPrimary: Color(0xFFC4E0FF),
    background: Color(0xFFF1F5FB),

    secondary: Color(0xFF4C76A7),
    surface: Color(0xFFB7F2FF),
    // surface: Color(0xffb3e6ff),
    onSurface: Color(0xFF2A7279),
    // onSurface: Color(0xFF56B1B7),
    shadow: Color(0xFFC4E0FF),
  ),

  // Appbar
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.white,
    color: Color(0xFF013250),
    // color: Color(0xFF4C76A7),
  ),

  // Buttons
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
    textStyle: TextStyle(
        fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.normal),
    backgroundColor: const Color(0xFFCBE5FF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  )),

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  )),

  // Text
  textTheme: TextTheme(
    // TODO: replace h4 with h6
    headline4: TextStyle(
      fontFamily: fontFamily,
      color: const Color(0xFFFFFFFF),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      fontFamily: fontFamily,
      color: const Color(0xFF4C76A7),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      fontFamily: fontFamily,
      color: const Color(0xFF013250),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: const Color(0xFF013250),
    ),

    caption: TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: const Color(0xffdef2ff),
    ),
  ),

  tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.normal,
      ),
      decoration: BoxDecoration(
          color: const Color(0xFF013250).withOpacity(.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF0E6092).withOpacity(.8),
          ))),
);
