import 'package:flutter/cupertino.dart';

class HomeModel with ChangeNotifier {
  final double _tabSize = 45.0;
  get tabSize => _tabSize;

  final double _horizontalSpacing = 80;

  double _totalWidth() {
    return (_tabSize * 2) + (_tabSize * 3) + _horizontalSpacing;
  }

  double center(width) {
    return width / 2.0 - _totalWidth() / 2;
  }

  double spacing(width, i) {
    return _horizontalSpacing * i - (i == 0 ? 0.0 : width - (_tabSize * 3));
  }

  double animation(i) {
    return _tabSize * (i == index ? 3.0 : 1.0);
  }

  int index = 0;
  double moveMiddle = 0.0;
  bool isTapped = false;

  void updateIndex(index) {
    if (index == 2) {
      translateX(-_tabSize * 2.0);
    } else {
      translateX(0.0);
    }

    this.index = index;
    notifyListeners();
  }

  void translateX(value) {
    moveMiddle = value;
    notifyListeners();
  }
}
