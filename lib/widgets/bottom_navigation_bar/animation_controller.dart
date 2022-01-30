import 'package:flutter/material.dart';

class FotogoAnimationController extends ChangeNotifier {
  late AnimationController controller;
  late Animation animation;

  FotogoAnimationController({
    required TickerProvider vsync,
    required Duration duration,
    Object? begin,
    Object? end,
  }) {
    controller = AnimationController(
      vsync: vsync,
      duration: duration,
    );

    animation = Tween(
      begin: begin,
      end: end,
    ).animate(controller);

    controller.addListener(() {
      print('afasfa');
      print(controller.value);
    });
  }

  void hide() {
    print('hide');
    controller.forward();
  }

  void show() {
    print('show');
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
