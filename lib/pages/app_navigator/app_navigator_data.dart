import 'package:flutter/material.dart';

import 'package:fotogo/pages/pages.dart';

class AppNavigatorData {
  int routeIndex = 0;

  List<Widget> routes = [
    const HomePage(),
    const AlbumsPage(),
    const PeoplePage(),
    const ProfilePage(),
  ];

  List<IconData> tabIcons = [
    Icons.home,
    Icons.collections_bookmark_outlined,
    Icons.people_outlined,
    Icons.account_circle_outlined,
  ];
  final List<String> tabTitles = ['Home', 'Albums', 'People', 'Profile'];
}
