import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import '/screens/settings_page/settings.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  final UserProvider _userProvider = UserProvider();

  ProfilePage({Key? key}) : super(key: key);

  Widget _getUserAvatar(String photoUrl) {
    double bannerHeight = 30.h;
    const double circleAvatarRadius = 40;
    const double userAvatarSize = circleAvatarRadius / 2 * 2.4;

    return Stack(
      children: [
        // BG
        Container(height: bannerHeight + userAvatarSize),
        // banner
        Container(
          height: bannerHeight,
          color: Colors.grey.shade300,
        ),
        // avatar
        Positioned(
          top: bannerHeight - userAvatarSize,
          left: 50.w - userAvatarSize,
          child: AppWidgets.fotogoUserAvatar(radius: circleAvatarRadius),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getUserAvatar(_userProvider.photoUrl ?? ''),
        const SizedBox(height: 15),
        Text(
          _userProvider.displayName ?? '',
          style: Theme.of(context).textTheme.headline4,
        ),
        // change account button
        Padding(
          padding: const EdgeInsets.only(top: 15, left: fPageMargin),
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
                    const Icon(Icons.switch_account, size: 18),
                    const SizedBox(width: 12),
                    Text(
                      'Switch account',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: 13,
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
        // settings
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SettingsPage())),
          // pushZoomTransitionRoute(context, const SettingsPage()),
          contentPadding: const EdgeInsets.only(left: fPageMargin),
        ),
      ],
    );
  }
}
