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

void pushOpenUpwardsTransitionRoute(BuildContext context, Widget child) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OpenUpwardsPageTransitionsBuilder().buildTransitions(
          null,
          context,
          animation,
          secondaryAnimation,
          child,
        ),
      ));
}

void pushZoomTransitionRoute(BuildContext context, Widget child) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ZoomPageTransitionsBuilder().buildTransitions(
          null,
          context,
          animation,
          secondaryAnimation,
          child,
        ),
      ));
}
