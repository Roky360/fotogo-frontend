import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fotogo/pages/albums/album_data.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AlbumCover extends StatelessWidget {
  // TODO: move these to AlbumData class
  final AlbumData data;

  AlbumCover({
    Key? key,
    required this.data,
    // TODO: figure dates format (what is the variable type..) AND make function to map this data type to string in various formats
  }) : super(key: key);

  final Size _size = Size(90.w, 150);
  late final double margin = _size.width * .05;
  final double _borderRadius = 20;
  final double blurAmount = 3;

  final Color textFGColor = Colors.white;

  String formatDatesToString(DateTimeRange timeRange) {
    if (timeRange.start.year == timeRange.end.year) {
      // Same year
      if (timeRange.start.month == timeRange.end.month) {
        // Same month and year
        return DateFormat('dd-dd').format(timeRange.start);
        // return "${timeRange.start.day}-${timeRange.end.day} "
        //     "${timeRange.start.month}, "
        //     "${timeRange.start.year == DateTime.now().year ? "" : timeRange.start.year}";
      } else {
        // Different months, same year
        return "";
      }
    } else {
      // Different years
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width,
      height: _size.height,
      decoration: BoxDecoration(
        // color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/test_images/amsterdam.jpg',
              width: _size.width,
              height: _size.height,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurAmount,
                  sigmaY: blurAmount,
                ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4 /*.copyWith()*/,
                            ),
                            const SizedBox(height: 2),
                            // Dates
                            Text(
                              formatDatesToString(data.dates),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: textFGColor, fontSize: 14),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Collaboration icon
                        Padding(
                          padding: EdgeInsets.all(margin),
                          child: Icon(
                            Icons.groups,
                            color: textFGColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // options (dropdown menu)
          // TODO: make this more visible
          Padding(
            padding: EdgeInsets.only(right: margin),
            child: Align(
              alignment: Alignment.topRight,
              child: DropdownButton<String>(
                items: <String>[
                  'Share',
                  'Delete',
                  'C',
                  'D',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                icon: Icon(
                  Icons.more_vert,
                  color: textFGColor,
                ),
                elevation: 8,
                // menuMaxHeight: _size.height,
              ),
            ),
          )
        ],
      ),
    );
  }
}
