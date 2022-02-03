import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlbumCover extends StatelessWidget {
  final String title;

  AlbumCover({
    Key? key,
    this.title = 'Amsterdam',
  }) : super(key: key);

  final Size _size = Size(90.w, 150);
  final double _borderRadius = 20;
  final double blurAmount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
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
                filter:
                    ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
                child: Container(
                  width: _size.width,
                  height: _size.height * .4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _size.width * .1,
                      vertical: 10
                    ),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline4/*.copyWith()*/,
                    ),
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
