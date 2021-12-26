import 'package:flutter/material.dart';

import 'package:fotogo/theme/style.dart';
import 'page_navigator.dart';

void main() {
  runApp(const Launcher());
}

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "fotogo",
      theme: themeData,
      initialRoute: '/page_navigator',
      routes: {
        '/page_navigator': (context) => PageNavigator(),
      },
    );
  }
}
