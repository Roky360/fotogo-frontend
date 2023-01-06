import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

part 'page_transitions.dart';

/// The light [ThemeData] of the application.
final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,

    // TODO: what to do with multiple (accent) colors?
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF013250),
      onPrimary: Color(0xffdef2ff),

      secondary: Color(0xFF4C76A7),

      tertiary: Color(0xFF19686a),
      tertiaryContainer: Color(0xFFa8eff0),

      background: Color(0xFFF1F5FB),

      surface: Color(0xFFB7F2FF),
      onSurface: Color(0xFF2A7279),
      // onSurface: Color(0xFF56B1B7),

      shadow: Color(0xFFC4E0FF),

      error: Color(0xFFEEC8C8),
      errorContainer: Color(0xFFD25555),
      // errorContainer: Color(0xFFC66161),
    ),
    dividerTheme: DividerThemeData(color: Colors.blueGrey[200]),

    // Appbar
    appBarTheme: AppBarTheme(
        shadowColor: Colors.white,
        color: const Color(0xFFD3F2F3),
        // color: const Color(0xFFF1F5FB),
        // color: Color(0xFF013250),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: const Color(0xFF013250),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF013250),
        ),
        elevation: 0
        // color: Color(0xFF4C76A7),
        ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        // TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // Buttons
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.normal),
      backgroundColor: const Color(0xFFB7F2FF).withOpacity(.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPrimary: const Color(0xffdef2ff),
      primary: const Color(0xFF013250),
      elevation: 3,
      shadowColor: const Color(0xFFa8eff0),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      textStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.normal),
      side: const BorderSide(width: .3, color: Color(0xFF013250)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      extendedTextStyle: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold),
      extendedPadding: const EdgeInsets.symmetric(horizontal: 15),
    ),

    // Card
    cardTheme: CardTheme(
      color: const Color(0xFFB7F2FF).withOpacity(.7),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),

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
        fontSize: 20,
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
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF013250),
        fontSize: 12,
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
            color: Colors.white),
        decoration: BoxDecoration(
            color: const Color(0xFF0E6092).withOpacity(.75),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color(0xFF013250).withOpacity(.8), width: .7))),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF2D79A8).withOpacity(.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(
          color: const Color(0xFF013250).withOpacity(.8),
          width: .7,
        ),
      ),
    ));
