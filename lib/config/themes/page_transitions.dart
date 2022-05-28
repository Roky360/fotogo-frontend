part of 'light_theme.dart';

final ThemeData lightThemeZoomPageTransition = lightTheme.copyWith(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
);

final ThemeData lightThemeOpenUpwardsPageTransition = lightTheme.copyWith(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
    },
  ),
);

ThemeData lightThemeSharedAxisPageTransition(
        {required SharedAxisTransitionType transitionType, Color? fillColor}) =>
    lightTheme.copyWith(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: transitionType, fillColor: fillColor),
        },
      ),
    );
