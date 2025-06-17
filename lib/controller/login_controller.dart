import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  int _id = 0;
  String _email = '';

  int get id => _id;
  String get email => _email;
  void setUser({required int id, required String email}) {
    _id = id;
    _email = email;
    notifyListeners();
  }

  void clearUser() {
    _id = 0;
    _email = '';
    notifyListeners();
  }
}
