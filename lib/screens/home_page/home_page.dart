import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../widgets/photo_view.dart';

part 'views/gallery_view.dart';

part 'views/album_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserProvider _userProvider = UserProvider();

  Widget getTopBar() {
    return Padding(
      padding: const EdgeInsets.all(pageMargin),
      child: Row(
        children: [
          Text(
            'Welcome back, ${_userProvider.displayName!.split(' ').first}',
            style: Theme.of(context).textTheme.headline4,
          ),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundImage:
                NetworkImage(_userProvider.photoUrl ?? ''),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          getTopBar(),
          const Expanded(child: GalleryView()),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
