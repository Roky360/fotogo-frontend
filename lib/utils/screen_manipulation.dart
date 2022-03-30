import 'package:flutter/cupertino.dart';

extension ProportionalInsets on BuildContext {
  EdgeInsets getProportionalInsets(
      {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    if (left < 0 || left > 100) throw RangeError.range(left, 0, 100);
    if (right < 0 || right > 100) throw RangeError.range(right, 0, 100);
    if (top < 0 || top > 100) throw RangeError.range(top, 0, 100);
    if (bottom < 0 || bottom > 100) throw RangeError.range(bottom, 0, 100);

    Size size = MediaQuery.of(this).size;
    Size onePercent = Size(size.width / 100.0, size.height / 100.0);
    return EdgeInsets.only(
        left: onePercent.width * left,
        right: onePercent.width * right,
        top: onePercent.height * top,
        bottom: onePercent.height * bottom);
  }

  EdgeInsets getProportionalInsetsBySize(Size size) {
    return getProportionalInsets(
        left: size.width,
        right: size.width,
        top: size.height,
        bottom: size.height);
  }

  double widthOf(double width) {
    return MediaQuery.of(this).size.width / 100 * width;
  }

  double heightOf(double height) {
    return MediaQuery.of(this).size.height / 100 * height;
  }

  double getPercentageFromWidth(double width) {
    return width * 100 / MediaQuery.of(this).size.width;
  }

  double getPercentageFromHeight(double height) {
    return height * 100 / MediaQuery.of(this).size.height;
  }

  Size getPixelCountFromScreenPercentage(
      {double width = 0, double height = 0}) {
    if (width < 0 || width > 100) throw RangeError.range(width, 0, 100);
    if (height < 0 || height > 100) throw RangeError.range(height, 0, 100);

    Size size = MediaQuery.of(this).size;
    Size onePercent = Size(size.width / 100.0, size.height / 100.0);

    return Size(onePercent.width * width, onePercent.height * height);
  }
}

Size? getScreenSize() {
  return WidgetsBinding.instance?.window.physicalSize;
}
