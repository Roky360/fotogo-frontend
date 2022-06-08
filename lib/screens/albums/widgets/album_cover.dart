import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/single_album/bloc/single_album_bloc.dart';
import 'package:fotogo/single_album/external_bloc/ext_single_album_bloc.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';

import '../../../album_details/album_data.dart';

class AlbumCover extends StatelessWidget {
  final AlbumData data;
  final double borderRadius;

  final Size _size = Size(100.w - pageMargin * 2, 150);
  late final double margin = _size.width * .06;
  final double blurAmount = 3;

  final Color textFGColor = Colors.white;

  AlbumCover({
    Key? key,
    required this.data,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size.width,
      height: _size.height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image(
              // image: MemoryImage(data.coverImage),
              image: NetworkImage(data.coverImage),
              fit: BoxFit.cover,
              width: _size.width,
              height: _size.height,
            ),
          ),
          // information with black gradient
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: _size.width,
              height: _size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(.6)],
                  )),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: _size.width,
                  height: _size.height * .4,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: margin,
                      right: margin,
                    ),
                    child: Row(
                      children: [
                        // Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: _size.width - margin * 2),
                              child: Text(
                                data.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: Colors.white, fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 3),
                            // Dates
                            Text(
                              formatDateRangeToString(data.dates),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: textFGColor, fontSize: 14),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Collaboration icon
                        data.permittedUsers.isNotEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(margin),
                                    child: Icon(
                                      Icons.groups,
                                      color: textFGColor,
                                    ),
                                  ),
                                  Text(
                                    data.permittedUsers.length.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // options (dropdown menu)
          Align(
            alignment: Alignment.topRight,
            child: fotogoPopupMenuIconButton(
              iconColor: textFGColor,
              items: [
                FotogoIconMenuItem('Share', Icons.share),
                FotogoIconMenuItem('Delete', Icons.delete,
                    onTap: () => context
                        .read<ExtSingleAlbumBloc>()
                        .add(ExtDeleteAlbumEvent(data.id))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
