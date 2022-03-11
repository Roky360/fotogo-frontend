import 'package:flutter/material.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:fotogo/utils/string_formatting.dart';
import 'package:fotogo/widgets/popup_menu_button.dart';
import 'package:sizer/sizer.dart';

class AlbumCover extends StatelessWidget {
  final AlbumData data;
  final double borderRadius;

  final Size _size = Size(100.w - pageMargin * 2, 150);
  late final double margin = _size.width * .05;
  final double blurAmount = 3;

  final Color textFGColor = Colors.white;

  AlbumCover({
    Key? key,
    required this.data,
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      height: _size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              data.coverImagePath,
              width: _size.width,
              height: _size.height,
              fit: BoxFit.cover,
            ),
          ),
          // information with black gradient
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: _size.width,
              height: _size.height,
              decoration: BoxDecoration(
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
                      top: 10,
                      left: margin,
                    ),
                    child: Row(
                      children: [
                        // Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              data.title,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 2),
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
                        data.isShared
                            ? Padding(
                                padding: EdgeInsets.all(margin),
                                child: Icon(
                                  Icons.groups,
                                  color: textFGColor,
                                ),
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
          // TODO: make this more visible
          Align(
            alignment: Alignment.topRight,
            child: fotogoPopupMenuIconButton(
              items: [
                IconMenuItem('Share', Icons.share),
                IconMenuItem('Delete', Icons.delete),
              ],
              iconColor: textFGColor,
            ),
          ),
        ],
      ),
    );
  }
}
