import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppNavigatorData {
  int routeIndex = 0;

  final AnimationController navigationBarController;
  final PanelController createAlbumPanelController;

  final List<NavigatorRoute> routes;

  AppNavigatorData(
      {required this.navigationBarController,
      required this.createAlbumPanelController,
      required this.routes});
}

class NavigatorRoute {
  final Widget widget;
  final IconData icon;
  late final IconData selectedIcon;
  final String title;

  NavigatorRoute(
      {required this.widget,
      required this.icon,
      selectedIcon,
      required this.title}) {
    this.selectedIcon = selectedIcon ?? icon;
  }
}
