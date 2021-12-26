import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotogo/page_navigator.dart';

///
extension SetupTabsNavigator on PageNavigator {
  /// Rebuilds the PageNavigator
  void rebuild() {
    calculateSelectedTabTextPositionAndSize();
  }

  void setupBuild() {
    firstBuild = false;
    setSystemNavigationBarStyle();
    calculateSelectedTabTextPositionAndSize();
  }

  void setSystemNavigationBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.deepPurpleAccent.withOpacity(.0),
    ));
  }

  void calculateSelectedTabTextPositionAndSize() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final GlobalKey currKey = tabTextKeys[pageIndex];
      final RenderBox box =
          currKey.currentContext?.findRenderObject() as RenderBox;
      selectedTabOffset = box.localToGlobal(Offset.zero);
      selectedTabSize = box.size;
      state.value++;
    });
  }
}
