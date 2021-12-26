import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

Widget fotogoLogo({double? height = 30}) {
  return SvgPicture.asset(
    'assets/fotogo-logo.svg',
    height: height,
  );
}

Widget tabInkAnimation(
    {required AnimationController controller, double fps = 60}) {
  return Lottie.asset(
    "assets/animations/selected_tab_ink_animation.json",
    frameRate: FrameRate(fps),
    controller: controller,
  );
}
