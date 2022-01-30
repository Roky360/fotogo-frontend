import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:widget_mask/widget_mask.dart';

import 'fotogo_painter.dart';

class FotogoShadowBNB extends StatelessWidget {
  final AppNavigatorData data;
  final Size barSize = Size(92.w, 60);
  final Size containerSize = Size(100.w, 130);
  late final Size tabSize = Size(barSize.width * .188, barSize.height);
  late final double borderRadius = barSize.height * .3;
  late final gapBetweenContainerToEdge =
      (containerSize.width - barSize.width) / 2;

  FotogoShadowBNB({
    Key? key,
    required this.data,
  }) : super(key: key);

  Widget getTab(BuildContext context, int index) {
    return Container(
      width: tabSize.width,
      height: tabSize.height,
      decoration: BoxDecoration(
        // border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
        ),
        onPressed: () {
          MediaQuery.of(context).size;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.tabIcons[index],
              color: const Color(0xFFFFFFFF),
              // color: const Color(0xFFD0F9FF),
              // color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              data.tabTitles[index],
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  double calculatePosition(int index) {
    if (index == 0 || index == 1) {
      return tabSize.width * index;
    } else {
      // index = 2, 3
      return (barSize.width - tabSize.width) -
          tabSize.width +
          tabSize.width * (index % 2);
    }
  }

  Widget getBar(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // bottom: -20,
          // left: gapBetweenContainerToEdge,
          // Wrapping container
          child: Container(
            width: containerSize.width,
            height: containerSize.height,
            // width: barSize.width,
            // height: barSize.height,
            child: Stack(
              // clipBehavior: Clip.antiAlias,
              children: [
                /*WidgetMask(
                  blendMode: BlendMode.srcATop,
                  childSaveLayer: true,
                  mask: Container(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child:*/
                // CustomPaint - bar shape
                Center(
                  child: CustomPaint(
                    size: barSize,
                    painter:
                    FotogoBNBPainter(context, borderRadius: borderRadius),
                  ),
                ),
                // ),
                // Center circle - new album button
                Center(
                  child: SizedBox(
                    width: barSize.height + 7,
                    height: barSize.height + 7,
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
                // Selected tab
                Positioned(
                  // top: (containerSize.height - tabSize.height) / 2,
                  left: calculatePosition(0),
                  child: Container(
                    width: tabSize.width,
                    height: barSize.height,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.0),
                        borderRadius: BorderRadius.circular(borderRadius)),
                  ),
                ),
                // Row of tabs
                Center(
                  child: SizedBox(
                    width: barSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTab(context, 0),
                        getTab(context, 1),
                        Spacer(),
                        getTab(context, 2),
                        getTab(context, 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double blurValue = 20;

    return Stack(
      children: [
        Positioned(
          bottom: 10,
          left: gapBetweenContainerToEdge,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: blurValue,
                sigmaX: blurValue,
                tileMode: TileMode.mirror,
              ),
              child: Container(
                width: barSize.width,
                height: barSize.height,
                color: const Color(0xFF48ABA8).withOpacity(.6),
                child: getBar(context),
              ),
            ),
          ),
        ),
      ],
    );
    // return Container(
    //   width: size.width,
    //   height: size.height,
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         bottom: -10,
    //         left: 0,
    //         child: Container(
    //           // color: Colors.red,
    //           width: containerSize.width,
    //           height: containerSize.height,
    //           child: Stack(
    //             clipBehavior: Clip.antiAlias,
    //             children: [
    //               WidgetMask(
    //                 blendMode: BlendMode.srcATop,
    //                 // childSaveLayer: true,
    //                 mask: Stack(
    //                   alignment: Alignment.center,
    //                   children: [
    //                     Positioned(
    //                       left: 50,
    //                       top: 110 / 2,
    //                       child: Container(
    //                         width: 20,
    //                         height: 20,
    //                         // color: Colors.lightBlue,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 // child: WidgetMask(
    //                 //   blendMode: BlendMode.srcATop,
    //                 //   childSaveLayer: true,
    //                 //   mask: Container(
    //                 //     color: Theme.of(context).colorScheme.surface,
    //                 //   ),
    //                   child: Center(
    //                     child: CustomPaint(
    //                       size: size,
    //                       painter: FotogoBNBPainter(context,
    //                           borderRadius: borderRadius),
    //                     ),
    //                   ),
    //                 // ),
    //               ),
    //               // Center circle - new album button
    //               Center(
    //                 child: SizedBox(
    //                   width: size.height + 7,
    //                   height: size.height + 7,
    //                   // width: 100,
    //                   // height: 100,
    //                   child: FloatingActionButton(
    //                     onPressed: () {},
    //                     backgroundColor: Colors.transparent,
    //                     elevation: 0,
    //                     highlightElevation: 0,
    //                     // on tap down
    //                     splashColor: Colors.red,
    //                     child: AppWidgets.fotogoLogoCircle(height: null),
    //                   ),
    //                 ),
    //               ),
    //               // Selected tab
    //               Positioned(
    //                 top: (containerSize.height - tabSize.width) * .54,
    //                 // top: containerSize.height*.27,
    //                 left: calculatePosition(0),
    //                 // left: (containerSize.width - tabSize.width) / 20,
    //                 child: Container(
    //                   width: tabSize.width,
    //                   height: size.height,
    //                   decoration: BoxDecoration(
    //                       color: Theme.of(context)
    //                           .colorScheme
    //                           .onSurface
    //                           .withOpacity(.5),
    //                       // color: Colors.red.withOpacity(.5),
    //                       borderRadius: BorderRadius.circular(borderRadius)),
    //                 ),
    //               ),
    //               // Row of tabs
    //               Center(
    //                 child: SizedBox(
    //                   width: size.width,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       getTab(context, 0),
    //                       getTab(context, 1),
    //                       Spacer(),
    //                       getTab(context, 2),
    //                       getTab(context, 3),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
