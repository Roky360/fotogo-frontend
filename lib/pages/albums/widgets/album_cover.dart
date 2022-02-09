import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlbumCover extends StatelessWidget {
  // TODO: move these to AlbumData class
  final String title;
  final String dates;

  AlbumCover({
    Key? key,
    this.title = 'Amsterdam',
    this.dates =
        '12-18 Jul, 2019', // TODO: figure dates format (what is the variable type..) AND make function to map this data type to string in various formats
  }) : super(key: key);

  final Size _size = Size(90.w, 150);
  late final double margin = _size.width * .05;
  final double _borderRadius = 20;
  final double blurAmount = 3;

  final Color textFGColor = Colors.white;

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
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4 /*.copyWith()*/,
                            ),
                            const SizedBox(height: 2),
                            // Dates
                            Text(
                              dates,
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
