import 'package:flutter/material.dart';

class BottamnavController with ChangeNotifier {
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  void setIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }
}
