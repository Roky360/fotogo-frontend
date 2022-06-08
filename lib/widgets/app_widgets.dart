import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:sizer/sizer.dart';

/// General widgets of the application.
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

  static Widget userCard(BuildContext context) {
    final UserProvider userProvider = UserProvider();

    return SizedBox(
      width: 80.w,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.shadow,
                backgroundImage: NetworkImage(userProvider.photoUrl ?? ''),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                // TODO: change text direction according to the language (+ detect language)
                Text(
                  userProvider.displayName ?? '',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                // Email
                Text(
                  userProvider.email,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // static Widget fotogoUserAvatar(BuildContext context, double size) {
  //   final UserProvider userProvider = UserProvider();
  //
  //   return
  // }

  static void fotogoSnackBar(BuildContext context,
      {required String content,
      FotogoSnackBarIcon icon = FotogoSnackBarIcon.fotogo}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            _getIcon(icon, Theme.of(context).colorScheme.onPrimary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                content,
                style:
                    Theme.of(context).textTheme.caption?.copyWith(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _getIcon(FotogoSnackBarIcon icon, Color color) {
    switch (icon) {
      case FotogoSnackBarIcon.info:
        return Icon(Icons.info_outlined, color: color);
      case FotogoSnackBarIcon.warning:
        return Icon(Icons.warning_amber_outlined, color: color);
      case FotogoSnackBarIcon.error:
        return Icon(Icons.error_outline, color: color);
      case FotogoSnackBarIcon.success:
        return Icon(Icons.done, color: color);
      case FotogoSnackBarIcon.fotogo:
        return SvgPicture.asset(
          'assets/logos/fotogo_logo_circle.svg',
          color: Colors.white,
          width: 22,
        );
    }
  }
}

enum FotogoSnackBarIcon { info, warning, error, success, fotogo }
