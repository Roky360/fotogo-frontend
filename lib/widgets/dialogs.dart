import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotogo/admin/admin_data_types.dart';
import 'package:fotogo/admin/bloc/admin_bloc.dart';
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
import '../single_album/external_bloc/ext_single_album_bloc.dart';

/// Custom application dialogs.
class FotogoDialogs {
  static void showAddToDialog(BuildContext context, List<File> images,
      {bool insideAlbum = true, String disabledAlbumId = ''}) {
    final List<SingleAlbumData> albumsData = SingleAlbumService().albumsData;
    const double thumbnailSize = 40;

    showDialog(
      context: context,
      builder: (_context) {
        return AlertDialog(
          backgroundColor: Theme.of(_context).colorScheme.background,
          title: Text('Add to', style: Theme.of(_context).textTheme.headline6),
          content: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 5.h, maxHeight: 50.h),
            child: SingleChildScrollView(
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
                            Navigator.pop(_context);
                            Navigator.push(
                                _context,
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
                                enabled: albumsData[index].data.id !=
                                    disabledAlbumId,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image. /*memory*/ network(
                                    albumsData[index].data.coverImage,
                                    width: thumbnailSize,
                                    height: thumbnailSize,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.none,
                                    errorBuilder:
                                        (context, exception, stackTrace) =>
                                            Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                          Icons
                                              .signal_wifi_connected_no_internet_4,
                                          color: Colors.grey.withOpacity(.6)),
                                    ),
                                  ),
                                ),
                                title: Text(albumsData[index].data.title),
                                contentPadding: const EdgeInsets.only(left: 8),
                                onTap: () {
                                  if (insideAlbum) {
                                    context.read<SingleAlbumBloc>().add(
                                        AddImagesToAlbumEvent(
                                            albumsData[index].data.id, images));
                                  } else {
                                    context.read<ExtSingleAlbumBloc>().add(
                                        ExtAddImagesToAlbumEvent(
                                            albumsData[index].data.id, images));
                                  }

                                  Navigator.pop(_context);
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
              onPressed: () => Navigator.pop(_context),
              child: const Text('Close'),
            ),
          ],
          buttonPadding: EdgeInsets.zero,
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
                    Navigator.popUntil(context, (route) => route.isFirst);
                    context.read<AuthBloc>().add(const DeleteAccountEvent());
                  },
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.red.shade700),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.red.shade200.withOpacity(.4)),
                      ),
                  child: const Text("Delete account"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  static void showAdminUserDetailsDialog(
      BuildContext context, UserData userData,
      {bool showDeleteButton = true}) {
    showDialog(
        context: context,
        builder: (_context) => AlertDialog(
              title: Text("Details",
                  style: Theme.of(_context).textTheme.headline6),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidgets.userCard(_context,
                      userData: userData, avatarRadius: 20),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: userData.uid));
                      Fluttertoast.showToast(
                          msg: "User ID copied to clipboard");
                    },
                    child: Text(
                      "uid: ${userData.uid}\n(tap to copy)",
                      textAlign: TextAlign.center,
                      style: Theme.of(_context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 13),
                    ),
                  )
                ],
              ),
              contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
              actions: [
                showDeleteButton
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(_context);
                          context
                              .read<AdminBloc>()
                              .add(DeleteUserAccountEvent(userData.uid));
                        },
                        style:
                            Theme.of(_context).textButtonTheme.style?.copyWith(
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.red.shade700),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red.shade200.withOpacity(.4)),
                                ),
                        child: const Text("Delete user"),
                      )
                    : const SizedBox(),
                TextButton(
                  onPressed: () => Navigator.pop(_context),
                  child: const Text("Cancel"),
                )
              ],
            ));
  }

  static Future<void> showAdminScreenSelectionDialog(
      BuildContext context) async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => );
    await Future.delayed(const Duration(milliseconds: 1));
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("Choose a screen to continue"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      "Choose whether to sign in as an admin and continue to the admin dashboard or sign in as a user."),
                  const SizedBox(height: 30),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, 0),
                    child: Text(
                      "Sign in as admin\n(admin dashboard)",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, 1),
                    child: Text(
                      "Sign in as user\n(main app)",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ));
  }
}
