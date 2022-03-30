import 'package:flutter/material.dart';
import 'package:fotogo/pages/auth_checker.dart';
import 'package:fotogo/pages/on_boarding_setup/on_boarding_page.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FotogoLauncher extends StatelessWidget {
  FotogoLauncher({Key? key}) : super(key: key);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isFirstLaunch() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('first_launch', false);
    return prefs.getBool('first_launch') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? const OnBoardingPage() : const AuthChecker();
        } else {
          return Center(child: AppWidgets.fotogoCircularLoadingAnimation());
        }
      },
    );
  }
}
