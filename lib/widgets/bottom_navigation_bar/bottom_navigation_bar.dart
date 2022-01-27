import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:widget_mask/widget_mask.dart';

import 'fotogo_painter.dart';

class FotogoBottomNavigationBar extends StatelessWidget {
  AppNavigatorData data;
  Size size = Size(92.w, 60);
  Size containerSize = Size(100.w, 130);
  late Size tabSize = Size(size.width * .185, size.height);
  late double borderRadius = size.height * .3;

  FotogoBottomNavigationBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  Widget getTab(BuildContext context, int index) {
    print(containerSize);
    return Container(
      width: tabSize.width,
      height: tabSize.height,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        splashColor: Colors.red,
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.tabIcons[index],
              color: Theme.of(context).colorScheme.primary,
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

  double calculatePosition(int index) { // TODO: Implement function
    if (index == 0 || index == 1) {
      return ((containerSize.width - tabSize.width) - (containerSize.width - size.width) / 2) - tabSize.width;
    } else { // index = 2, 3
      return ((containerSize.width - tabSize.width) - (containerSize.width - size.width) / 2) - tabSize.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -10,
          left: 0,
          child: Container(
            // color: Colors.red,
            width: containerSize.width,
            height: containerSize.height,
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
                        painter: FotogoBNBPainter(context,
                            borderRadius: borderRadius),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: size.height + 7,
                    height: size.height + 7,
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
                  child: SizedBox(
                    width: size.width,
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
                Positioned(
                  top: (containerSize.height - tabSize.width) * .54, // top: containerSize.height*.27,
                  left: calculatePosition(0),
                  // left: (containerSize.width - tabSize.width) / 20,
                  child: Container(
                    width: tabSize.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.5),
                        borderRadius: BorderRadius.circular(borderRadius)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
