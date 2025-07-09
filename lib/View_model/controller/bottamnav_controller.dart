import 'package:flutter/material.dart';
/// Controller for managing the selected index of the bottom navigation bar.
class BottamnavController with ChangeNotifier {
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  void setIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }
}
