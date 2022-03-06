import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/models/user_bloc/user_bloc.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount account = context.read<UserBloc>().user!;

    return Center(
      child: Column(
        children: [
          _getUserAvatar(account.photoUrl!),
          const SizedBox(height: 15),
          Text(account.displayName ?? '', style: Theme.of(context).textTheme.headline6,),
          // change account button
          Padding(
            padding: const EdgeInsets.only(top: 10, left: pageMargin),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.read<UserBloc>().signOut(context),
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
        ],
      ),
    );
  }
}
