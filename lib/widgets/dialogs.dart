import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/screens/create_album/create_album_page.dart';
import 'package:fotogo/widgets/section.dart';
import 'package:fotogo/widgets/shared_axis_route.dart';
import 'package:sizer/sizer.dart';

class FotogoDialogs {
  static void showAddToDialog(BuildContext context, List<File> images) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Add to'),
          content: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 5.h, maxHeight: 15.h),
            child: Column(
              children: [
                FotogoSection(
                  padding: EdgeInsets.zero,
                  title: 'Create',
                  body: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_album_outlined),
                        title: const Text('Album'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              sharedAxisRoute(
                                  widget: CreateAlbumPage(
                                images: images,
                              )));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static void showAppDialog(BuildContext context) {
    showAboutDialog(
      context: context,
    );
  }

  static void showDeleteAccountDialog(BuildContext context) {
    final UserProvider userProvider = UserProvider();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text('Delete Account'),
              content: Text("""This action will delete all the data related to this user: ${userProvider.email}.
              This action """, style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14
              ),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<AuthBloc>().add(const DeleteAccountEvent());
                  },
                  child: const Text("Delete account"),
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                )
              ],
            ));
  }
}
