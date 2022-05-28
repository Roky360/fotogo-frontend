import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

part 'page_transitions.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,

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
      error: Color(0xFFEEC8C8),
      errorContainer: Color(0xFFD25555),
      // errorContainer: Color(0xFFC66161),
    ),

    // Appbar
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.white,
      color: Color(0xFF013250),
      // color: Color(0xFF4C76A7),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // Buttons
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.normal
          // color: const Color(0xFF187D88),
          ),
      backgroundColor: const Color(0xFFB7F2FF).withOpacity(.4),
      // backgroundColor: const Color(0xFFCBE5FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.normal),
      side: const BorderSide(width: .2, color: Color(0xFF013250)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )),

    // Text
    textTheme: TextTheme(
      // TODO: replace h4 with h6
      headline4: TextStyle(
        fontFamily: fontFamily,
        color: const Color(0xFF013250),
        fontSize: 22,
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
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),

      subtitle1: TextStyle(
        fontFamily: fontFamily,
        color: const Color(0xFF013250),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),

      bodyText1: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          color: const Color(0xFF013250),
          fontSize: 14),

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
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color(0xFF0E6092).withOpacity(.8)),
      ),
      backgroundColor: const Color(0xFF013250).withOpacity(.7),
    ));
