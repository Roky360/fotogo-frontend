import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  fontFamily: _TextThemes.fontFamily,
  textTheme: const TextTheme(
    caption: TextStyle(
        color: Color(0xFF013250), fontSize: 22, fontWeight: FontWeight.bold),
    headline1: TextStyle(
      color: Color(0xFF013250),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
        color: Color(0xFF4C76A7), fontSize: 22, fontWeight: FontWeight.bold),

  ),

  textButtonTheme: _ButtonThemes.textButtonTheme,
  elevatedButtonTheme: _ButtonThemes.elevatedButtonTheme,

  colorScheme: ColorScheme(
    primary: const Color(0xFF013250),
    // onPrimary: const Color(0xFF450707),
    onPrimary: const Color(0xFFC4E0FF),

    background: const Color(0xFFF1F5FB),

    // TODO: Fix dark mode colors
    /*brightness: ThemeMode.system == ThemeMode.light
    ? Brightness.light : Brightness.dark,*/
    brightness: Brightness.light,
    surface: Colors.grey.shade800,
    onSurface: const Color(0xFF5786A7),
    // onSurface: Colors.grey.shade200,
    error: Colors.redAccent,
    onError: Colors.red,
    onBackground: Colors.amber,
    secondary: Colors.grey.shade600,
    onSecondary: Colors.amber,
  ),

  appBarTheme: const AppBarTheme(
    shadowColor: Colors.white,
    color: Color(0xFF4C76A7),
    // color: Color(0xFFC4E0FF),
  ),
  shadowColor: Colors.white,
  // hoverColor: Colors.grey[500],
  // splashColor: Colors.grey[600],
);

class _ButtonThemes {
  static final textButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 17, vertical: 12)),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontFamily: _TextThemes.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFCBE5FF)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)))));

  static final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontFamily: _TextThemes.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 37, vertical: 16)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))));
}

class _TextThemes {
  static final fontFamily =
      GoogleFonts.getFont('Montserrat Alternates').fontFamily;
}
