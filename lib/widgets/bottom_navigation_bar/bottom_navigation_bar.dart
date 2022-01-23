import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:widget_mask/widget_mask.dart';

import 'fotogo_painter.dart';

Widget fotogoBottomNavigationBar(BuildContext context, AppNavigatorData data) {
  Size size = Size(90.w, 65);

  return Stack(
    children: [
      Positioned(
        bottom: -10,
        left: 0,
        child: Container(
          // color: Colors.red,
          width: 100.w,
          height: 130,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              WidgetMask(
                blendMode: BlendMode.srcATop,
                childSaveLayer: true,
                mask: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 50,
                      top: 110 / 2,
                      child: Container(
                        width: 20,
                        height: 20,
                        // color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
                child: WidgetMask(
                  blendMode: BlendMode.srcATop,
                  childSaveLayer: true,
                  mask: Container(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: size,
                      painter: FotogoBNBPainter(context),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 72,
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      data.routes.length,
                      (index) => Row(
                            children: [
                              SizedBox(
                                width: 63,
                                height: size.height,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Icon(
                                    data.tabIcons[index],
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(index == 0 ? 20 : 0),
                                      bottomLeft: Radius.circular(index == 0 ? 20 : 0),
                                      topRight: Radius.circular(index == 3 ? 20 : 0),
                                      bottomRight: Radius.circular(index == 3 ? 20 : 0),
                                    ),
                                  ))),
                                ),
                              ),
                              SizedBox(width: index == 1 ? 95 : 0),
                            ],
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
