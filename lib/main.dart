import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fotogo/config/themes/light_theme.dart';
import 'package:fotogo/pages/app_navigator/app_navigator.dart';
import 'package:fotogo/pages/on_boarding_setup/on_boarding_page.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FotogoApp());
}

class FotogoApp extends StatelessWidget {
  const FotogoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "fotogo",
          theme: lightTheme,
          initialRoute: '/setup',
          routes: {
            '/page_navigator': (context) => const AppNavigator(),
            '/setup': (context) => const LoginAndSetup(),
          },
        );
      },
    );
  }
}
