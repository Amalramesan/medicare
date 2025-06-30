import 'package:flutter/material.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';

class LoginController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storage = LocalStorageService();

  bool _isLoading = false;
  String? _error;
  LoginModel? _loggedUser;

  bool get isLoading => _isLoading;
  String? get error => _error;
  LoginModel? get loggedUser => _loggedUser;

  /// Login and save tokens/user ID
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await _authRepository.loginUser(email, password);
      _loggedUser = response;

      final user = response.data.user;
      final access = response.data.access;
      final refresh = response.data.refresh;

      await _storage.saveTokens(access, refresh);
      await _storage.savePatientId(user.id);

      _showMessage(context, "Login success: ${response.message}");

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      _error = e.toString();
      _showMessage(context, "Login failed: $_error");
    } finally {
      _setLoading(false);
    }
  }

  /// Logout and clear saved user info
  Future<void> logout() async {
    _loggedUser = null;
    _error = null;
    _setLoading(false);
    notifyListeners();


  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
