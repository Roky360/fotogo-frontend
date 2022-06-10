import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../single_album/external_bloc/ext_single_album_bloc.dart';
import 'views/gallery_photo_view.dart';

part 'views/gallery_view.dart';

part 'views/album_view.dart';

class HomePage extends StatelessWidget {
  final void Function(int) changeAppNavigatorRoute;

  final UserProvider _userProvider = UserProvider();

  HomePage({Key? key, required this.changeAppNavigatorRoute}) : super(key: key);

  Widget getTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(fPageMargin),
      child: Row(
        children: [
          Text(
            'Welcome back, ${_userProvider.displayName!.split(' ').first}',
            style: Theme.of(context).textTheme.headline4,
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

// class HomePage extends StatefulWidget {
//   final Function changeAppNavigatorRoute;
//
//   const HomePage({Key? key, required this.changeAppNavigatorRoute})
//       : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final UserProvider _userProvider = UserProvider();
//
//   Widget getTopBar() {
//     return Padding(
//       padding: const EdgeInsets.all(pageMargin),
//       child: Row(
//         children: [
//           Text(
//             'Welcome back, ${_userProvider.displayName!.split(' ').first}',
//             style: Theme.of(context).textTheme.headline4,
//           ),
//           const Spacer(),
//           AppWidgets.fotogoUserAvatar(context),
//           // CircleAvatar(
//           //   radius: 18,
//           //   backgroundImage: NetworkImage(_userProvider.photoUrl ?? ''),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           getTopBar(),
//           const GalleryView(),
//           const SizedBox(height: 70),
//         ],
//       ),
//     );
//   }
// }
