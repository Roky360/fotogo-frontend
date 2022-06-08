import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/config/themes/light_theme.dart';
import 'package:fotogo/screens/create_album/create_album_page.dart';
import '/screens/settings_page/settings.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProvider _userProvider = UserProvider();

  Widget _getUserAvatar(String photoUrl) {
    double bannerHeight = 30.h;
    double circleAvatarRadius = 50;

    return Column(
      children: [
        Stack(
          children: [
            // BG
            Container(
              height: bannerHeight + circleAvatarRadius,
              color: Colors.transparent,
            ),
            // banner
            Container(
              height: bannerHeight,
              color: Colors.grey.shade300,
            ),
            // avatar
            Positioned(
              top: bannerHeight - circleAvatarRadius,
              left: 50.w - circleAvatarRadius,
              child: CircleAvatar(
                radius: circleAvatarRadius,
                backgroundImage: NetworkImage(photoUrl),
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _getUserAvatar(_userProvider.photoUrl ?? ''),
          const SizedBox(height: 15),
          Text(
            _userProvider.displayName ?? '',
            style: Theme.of(context).textTheme.headline4,
          ),
          // change account button
          Padding(
            padding: const EdgeInsets.only(top: 10, left: pageMargin),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () =>
                    context.read<AuthBloc>().add(const SignOutEvent()),
                child: SizedBox(
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.switch_account,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Switch account',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage())),
            // pushZoomTransitionRoute(context, const SettingsPage()),
            contentPadding: const EdgeInsets.only(left: pageMargin),
          ),
          // OpenContainer(
          //   transitionType: ContainerTransitionType.fadeThrough,
          //   closedColor: Colors.transparent,
          //   closedElevation: 0,
          //   openElevation: 0,
          //   closedShape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          //   closedBuilder: (context, action) {
          //     return ListTile(
          //       leading: const Icon(Icons.settings),
          //       title: const Text("Settings"),
          //       onTap: action,
          //       contentPadding: const EdgeInsets.only(left: pageMargin),
          //     );
          //   },
          //   openBuilder: (context, action) => const SettingsPage(),
          // ),
        ],
      ),
    );
  }
}
