import 'package:flutter/material.dart';

class BottomNavigationController extends ChangeNotifier {
  int _index = 0;
  int get tabIndex => _index;

  // 탭 인덱스 변경
  void changeTabIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
