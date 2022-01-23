import 'package:flutter/material.dart';

import 'package:fotogo/config/themes/light_theme.dart';
import 'package:fotogo/config/themes/style.dart';
import 'package:fotogo/pages/app_navigator/app_navigator.dart';
import 'pages/app_navigator/page_navigator.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const Launcher());
}

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "fotogo",
          theme: lightTheme,
          initialRoute: '/page_navigator',
          routes: {
            '/page_navigator': (context) {
              return const AppNavigator();
            },
          },
        );
      },
    );
  }
}
