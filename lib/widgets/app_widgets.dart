import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class AppWidgets {
  // TODO: make factory for both constructors
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

  static Widget fotogoCircularLoadingAnimation(
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

  static Widget userCard(BuildContext context, GoogleSignInAccount account) {
    return SizedBox(
      width: 80.w,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                backgroundImage: NetworkImage(account.photoUrl!),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                // TODO: change text direction according to the language (+ detect language)
                Text(
                  account.displayName ?? '',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                // Email
                Text(
                  account.email,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
