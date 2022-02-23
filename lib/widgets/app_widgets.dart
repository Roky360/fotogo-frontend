import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
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

  static Widget circularLoadingAnimation(
      {/*required AnimationController controller,*/ double fps = 60}) {
    return const CircularProgressIndicator();
    // return Lottie.asset(
    //   "assets/animations/selected_tab_ink_animation.json",
    //   frameRate: FrameRate(fps),
    //   controller: controller,
    // );
  }

  static Future<DateTimeRange?> fotogoDateRangePicker(
      BuildContext context) async {
    return showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10),
        helpText: "SELECT RANGE DATES",
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                    button: TextStyle(fontFamily: fontFamily),
                    overline: TextStyle(fontFamily: fontFamily),
                    bodyText2: TextStyle(
                        fontFamily: fontFamily,
                        color: Theme.of(context).colorScheme.primary),
                  ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              )),
            ),
            child: child!,
          );
        });
  }
}
