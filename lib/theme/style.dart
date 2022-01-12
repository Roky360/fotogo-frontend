import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

String? _fontFamily = GoogleFonts.getFont('Montserrat Alternates').fontFamily;

ThemeData themeData = ThemeData(
  fontFamily: _fontFamily,
  textTheme: const TextTheme(
    caption: TextStyle(
        color: Color(0xFF013250), fontSize: 22, fontWeight: FontWeight.bold),
    headline1: TextStyle(

    ),
  ),

  colorScheme: ColorScheme(
    primary: const Color(0xFF013250),
    onPrimary: const Color(0xFF6794B1),

    background: const Color(0xFFF1F5FB),

    // TODO: Fix dark mode colors
    /*brightness: ThemeMode.system == ThemeMode.light
    ? Brightness.light : Brightness.dark,*/
    brightness: Brightness.light,
    surface: Colors.grey.shade800,
    onSurface: Colors.grey.shade200,
    error: Colors.redAccent,
    onError: Colors.red,
    onBackground: Colors.amber,
    secondary: Colors.grey.shade600,
    onSecondary: Colors.amber,
  ),

  appBarTheme: AppBarTheme(
    shadowColor: Colors.white,
    color: Color(0xFFC4E0FF),
  ),
  shadowColor: Colors.white,
  // hoverColor: Colors.grey[500],
  // splashColor: Colors.grey[600],
);
