import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/page_navigator.dart';
import 'package:fotogo/utils/screen_manipulation.dart';
import 'package:fotogo/widgets/app_widgets.dart';

extension BottomTabBar on PageNavigator {
  Widget bottomTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        height: containerSize.height,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.5),
                spreadRadius: -10,
                blurRadius: 40,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  4,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context
                                .getPixelCountFromScreenPercentage(width: .0)
                                .width),
                        child: Stack(
                          children: [
                            Positioned(
                              top: containerSize.height / 2 - lottieSize / 2,
                              left: containerSize.width / 2 - lottieSize / 2,
                              width: lottieSize,
                              height: lottieSize,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.4),
                                    BlendMode.modulate),
                                child: AppWidgets.tabInkAnimation(
                                    controller: inkAnimationControllers[index]),
                              ),
                            ),
                            Container(
                              width: containerSize.width,
                              height: containerSize.height,
                              color: Colors.purple.withOpacity(.0),
                              child: InkWell(
                                radius: 0,
                                onTap: () {
                                  // if (currentIndex != index) {
                                  pageIndex = index;
                                  inkAnimationControllers[index].forward();
                                  rebuild();
                                  // }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Tab Icon
                                    Icon(
                                      tabIcons[index],
                                      color: pageIndex == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    // Tab Label
                                    Text(
                                      tabTitles[index],
                                      key: tabTextKeys[index],
                                      style: TextStyle(
                                        fontWeight: pageIndex == index
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: pageIndex == index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
            AnimatedPositioned(
              height: 3,
              width: selectedTabSize.width,
              left: selectedTabOffset.dx - 10,
              bottom: 0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubicEmphasized,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                // Colors.blue[200]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
