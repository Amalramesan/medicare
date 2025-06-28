import 'package:flutter/material.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _error;
  LoginModel? _loggedUser;

  bool get isLoading => _isLoading;
  String? get error => _error;
  LoginModel? get loggedUser => _loggedUser;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      final response = await _authRepository.loginUser(email, password);
      _loggedUser = response;
      _setLoading(false);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login success: ${response.message}")),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      _setLoading(false);
      _error = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: $_error")),
        );
      }
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logout() async {
    _loggedUser = null;
    _setLoading(false);
    _error = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('patient_id');
    await prefs.remove('auth_token');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
