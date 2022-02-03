import 'package:flutter/material.dart';

import 'package:fotogo/pages/pages.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppNavigatorData {
  int routeIndex = 1;

  late final AnimationController navigationBarController;

  late final PanelController createAlbumPanelController;

  late final List<NavigatorRoute> routes;

  AppNavigatorData() {
    routes = List.generate(
      4,
      (index) => NavigatorRoute(
        widget: [
          HomePage(this),
          AlbumsPage(),
          PeoplePage(),
          ProfilePage(),
        ][index],
        icon: [
          Icons.home,
          Icons.collections_bookmark_outlined,
          Icons.people_outlined,
          Icons.account_circle_outlined,
        ][index],
        title: ['Home', 'Albums', 'People', 'Profile'][index],
      ),
      growable: false,
    );
  }

// List<Widget> routes = [
//   HomePage(),
//   AlbumsPage(),
//   PeoplePage(),
//   ProfilePage(),
// ];
//
// static const List<IconData> tabIcons = [
//   Icons.home,
//   Icons.collections_bookmark_outlined,
//   Icons.people_outlined,
//   Icons.account_circle_outlined,
// ];
// static const List<String> tabTitles = ['Home', 'Albums', 'People', 'Profile'];
}

class NavigatorRoute {
  final Widget widget;
  final IconData icon;
  final String title;

  NavigatorRoute(
      {required this.widget, required this.icon, required this.title});
}
