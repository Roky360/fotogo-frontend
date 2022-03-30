import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Route sharedAxisRoute(
    {required Widget widget,
    SharedAxisTransitionType transitionType =
        SharedAxisTransitionType.scaled}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SharedAxisTransition(
      fillColor: Colors.transparent,
      transitionType: transitionType,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    ),
  );
}
