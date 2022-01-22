import 'package:flutter/material.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

import 'fotogo_painter.dart';

Widget fotogoBottomNavigationBar(BuildContext context) {
  Size size = Size(90.w, 65);

  return Stack(
    children: [
      Positioned(
        bottom: 20,
        left: 0,
        child: Container(
          // color: Colors.white,
          width: 100.w,
          height: 80,
          child: Stack(
            children: [
              Center(
                child: CustomPaint(
                  size: size,
                  painter: FotogoBNBPainter(context,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              Center(
                child: SizedBox(
                  width:  72,
                  height: 72,
                  // width: 100,
                  // height: 100,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    highlightElevation: 0,
                    // on tap down
                    splashColor: Colors.red,
                    child: AppWidgets.fotogoLogoCircle(height: null),
                  ),
                ),
              ),
              // Container(
              //   width: size.width,
              //   height: size.height,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              //       SizedBox(
              //         width: size.width * .2,
              //       ),
              //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ],
  );
}
