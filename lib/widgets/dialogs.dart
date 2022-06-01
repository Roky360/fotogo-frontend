import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/screens/create_album/create_album_page.dart';
import 'package:fotogo/single_album/single_album_data.dart';
import 'package:fotogo/single_album/single_album_service.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/section.dart';
import 'package:fotogo/widgets/shared_axis_route.dart';
import 'package:sizer/sizer.dart';

import '../single_album/bloc/single_album_bloc.dart';

/// Custom application dialogs.
class FotogoDialogs {
  static void showAddToDialog(BuildContext context, List<File> images) {
    final List<SingleAlbumData> albumsData = SingleAlbumService().albumsData;
    const double thumbnailSize = 40;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Add to', style: Theme.of(context).textTheme.headline6),
          content: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 5.h, maxHeight: 40.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // create
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
                  const SizedBox(height: 25),
                  // all albums
                  albumsData.isNotEmpty
                      ? FotogoSection(
                          padding: EdgeInsets.zero,
                          title: 'Existing album',
                          body: Column(
                            children: List.generate(albumsData.length, (index) {
                              return ListTile(
                                leading: Image./*memory*/network(
                                  albumsData[index].data.coverImage,
                                  width: thumbnailSize,
                                  height: thumbnailSize,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(albumsData[index].data.title),
                                contentPadding: const EdgeInsets.only(left: 8),
                                onTap: () {
                                  context
                                      .read<SingleAlbumBloc>()
                                      .add(AddImagesToAlbumEvent(
                                        albumsData[index].data.id,
                                        images,
                                      ));
                                  Navigator.pop(context);
                                },
                              );
                            }),
                          ))
                      : const SizedBox(),
                ],
              ),
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
        applicationIcon: AppWidgets.fotogoLogoFull(),
        applicationName: "",
        children: [] // TODO: write some description here
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
              title: Text('Delete Account',
                  style: Theme.of(context).textTheme.headline6),
              content: Text(
                'You are about to delete all the data related to this user: '
                '${userProvider.email}.\n'
                'This action cannot be undone.',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
              ),
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
                            MaterialStateProperty.all(Colors.red.shade700),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.red.shade200.withOpacity(.4)),
                      ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ));
  }
}
