import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AnimationController createTabAnimationController(
    {@required duration, initialValue = .6}) {
  final AnimationController animationController = useAnimationController(
    duration: duration,
    initialValue: initialValue,
  );
  animationController.addListener(() {
    if (animationController.value == 1) {
      animationController.value = 0;
      // animationController.stop();
    }
  });
  return animationController;
}
