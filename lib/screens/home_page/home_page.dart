import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/utils/permission_handler.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';

import 'views/gallery_photo_view.dart';

part 'views/gallery_view.dart';

part 'views/album_view.dart';

class HomePage extends StatelessWidget {
  final void Function(int) changeAppNavigatorRoute;

  final UserProvider _userProvider = UserProvider();

  HomePage({Key? key, required this.changeAppNavigatorRoute}) : super(key: key);

  String greetingMessage() {
    final int currHour = DateTime.now().hour;

    if (currHour <= 12) {
      return 'Good morning';
    } else if ((currHour > 12) && (currHour <= 16)) {
      return 'Good afternoon';
    } else if ((currHour > 16) && (currHour < 20)) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  Widget getTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(fPageMargin),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 70.w),
            child: Text(
              "${greetingMessage()}, ${_userProvider.displayName!.split(' ').first}",
              style: Theme.of(context).textTheme.headline4,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          // change route to profile page
          AppWidgets.fotogoUserAvatar(onTap: () => changeAppNavigatorRoute(3)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          getTopBar(context),
          const GalleryView(),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
