import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  AppNavigatorData appNavigatorData = AppNavigatorData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: fotogoBottomNavigationBar(context, appNavigatorData),
    );
  }
}

