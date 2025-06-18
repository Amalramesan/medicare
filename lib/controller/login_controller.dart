import 'package:flutter/material.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/utilities/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
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
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      LoginModel response = await _apiServices.loginuser(email, password);

      _loggedUser = response;

      await saveTokens(response.data.access, response.data.refresh);

      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('patient_id', response.data.user.id);

      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login success: ${response.message}")),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: $_error")));
    }
  }

  logout() async {
    _loggedUser = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('patient_id');
    await clearTokens();
  }
}
