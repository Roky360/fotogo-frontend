import 'package:flutter/material.dart';
import 'package:fotogo/screens/auth_checker.dart';
import 'package:fotogo/screens/on_boarding_setup/welcome_page.dart';
import 'package:fotogo/widgets/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Launches fotogo app.
///
/// This is the first widget that the [MaterialApp] calls. It decided what to
/// launch first, based on whether this is the first launch
/// (shows [WelcomePage]) or not (gives control to [AuthChecker]).
class FotogoLauncher extends StatelessWidget {
  FotogoLauncher({Key? key}) : super(key: key);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isFirstLaunch() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('first_launch') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? WelcomePage() : const AuthChecker();
        } else {
          return const FotogoSplashScreen(
            message: "",
            showLoadingAnimation: true,
          );
        }
      },
    );
  }
}
