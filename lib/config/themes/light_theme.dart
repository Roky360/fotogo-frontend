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
  ),

  shadowColor: const Color(0xFFC4E0FF),

  // Appbar
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.white,
    // color: Color(0xFF4C76A7),
    color: Color(0xFFC4E0FF),
  ),

  // Buttons
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 17, vertical: 12)),
    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.normal)),
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFCBE5FF)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
  )),

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold)),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 37, vertical: 16)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  )),

  // Text
  textTheme: TextTheme(
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
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF013250),
    ),
  ),
);
