import 'package:flutter/material.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/data/Response/api_response.dart'; // Assuming this is the correct path

class LoginController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storage = LocalStorageService();

  ApiResponse<LoginModel> _loginResponse = ApiResponse.loading();
  ApiResponse<LoginModel> get loginResponse => _loginResponse;

  /// Login and save tokens/user ID
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _loginResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final response = await _authRepository.loginUser(email, password);
      _loginResponse = ApiResponse.completed(response);
      notifyListeners();

      final user = response.data.user;
      final access = response.data.access;
      final refresh = response.data.refresh;
     await _storage.init(); 
      await _storage.saveTokens(access, refresh);
      await _storage.savePatientId(user.id);

      _showMessage(context, "Login success: ${response.message}");

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      _loginResponse = ApiResponse.error(e.toString());
      notifyListeners();
      _showMessage(context, "Login failed: ${e.toString()}");
    }
  }

  /// Logout and clear saved user info
  Future<void> logout() async {
    await _storage.init(); 
    await _storage.clearTokens();
    _loginResponse = ApiResponse.loading(); // or null/initial state
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
