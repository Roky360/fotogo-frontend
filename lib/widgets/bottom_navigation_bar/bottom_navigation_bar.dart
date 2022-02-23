import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

class FotogoBottomNavigationBar extends StatelessWidget {
  final AppNavigatorData data;
  final Color foregroundColor;

  final Size _barSize = Size(92.w, 60);
  final Size _containerSize = Size(100.w, 130);
  late final Size _tabSize = Size(_barSize.width * .188, _barSize.height);
  late final double _borderRadius = _barSize.height * .3;
  late final _gapBetweenContainerToEdge =
      (_containerSize.width - _barSize.width) / 2;

  final Function onTabTap;
  final VoidCallback onMiddleButtonTap;

  final Animation controller;

  FotogoBottomNavigationBar({
    Key? key,
    this.foregroundColor = Colors.white,
    required this.data,
    required this.onTabTap,
    required this.onMiddleButtonTap,
    required this.controller,
    // required this.animationController,
  }) : super(key: key);

  double _calculatePosition(int index) {
    if (index == 0 || index == 1) {
      return _tabSize.width * index;
    } else {
      // index = 2, 3
      return (_barSize.width - _tabSize.width) -
          _tabSize.width +
          _tabSize.width * (index % 2);
    }
  }

  Widget _getTab(BuildContext context, int index) {
    return SizedBox(
      width: _tabSize.width,
      height: _tabSize.height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
        onPressed: () => onTabTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.routes[index].icon,
              color: foregroundColor,
            ),
            const SizedBox(height: 2),
            Text(
              data.routes[index].title,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBar(BuildContext context) {
    return Stack(
      children: [
        // Center circle - new album button
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: foregroundColor,
              ),
            ),
            Center(
              child: SizedBox(
                width: _barSize.height + 7,
                height: _barSize.height + 7,
                child: FloatingActionButton(
                  onPressed: onMiddleButtonTap,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  highlightElevation: 0,

                  // on tap down
                  splashColor: Colors.transparent,
                  child: AppWidgets.fotogoLogoCircle(height: null),
                ),
              ),
            ),
          ],
        ),
        // Selected tab
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutExpo,
          left: _calculatePosition(data.routeIndex),
          child: Container(
            width: _tabSize.width,
            height: _barSize.height,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                borderRadius: BorderRadius.circular(_borderRadius)),
          ),
        ),
        // Row of tabs
        Center(
          child: SizedBox(
            width: _barSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  data.routes.length, (index) => _getTab(context, index))
                ..insert(2, const Spacer()),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double blurAmount = 20;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? staticChild) {
            return Positioned(
              left: _gapBetweenContainerToEdge,
              bottom: controller.value * 70 - 60,
              child: staticChild!,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: blurAmount,
                sigmaX: blurAmount,
                tileMode: TileMode.mirror,
              ),
              child: Container(
                width: _barSize.width,
                height: _barSize.height,
                color: const Color(0xFF48ABA8).withOpacity(.6),
                child: _getBar(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
