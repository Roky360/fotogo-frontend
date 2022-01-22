import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppWidgets {
  static Widget fotogoLogoFull({double? height = 30}) {
    return SvgPicture.asset(
      'assets/logos/fotogo_logo_full.svg',
      height: height,
    );
  }

  static Widget fotogoLogoCircle({double? height = 30}) {
    return SvgPicture.asset(
      'assets/logos/fotogo_logo_circle.svg',
      height: height,
    );
  }

  static Widget tabInkAnimation(
      {required AnimationController controller, double fps = 60}) {
    return Lottie.asset(
      "assets/animations/selected_tab_ink_animation.json",
      frameRate: FrameRate(fps),
      controller: controller,
    );
  }
}
