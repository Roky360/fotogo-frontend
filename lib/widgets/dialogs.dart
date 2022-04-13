import 'dart:io';

import 'package:flutter/material.dart';
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
}
