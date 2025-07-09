import 'package:flutter/material.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';
import 'package:med_care/repository/auth_resporitary.dart';
/// Controller for managing the user login functionality.
/// Responsibilities:
/// - Handles form validation using a [GlobalKey<FormState>]
///- Manages loading state during the login process
/// - Uses [AuthRepository] to perform login requests
/// - Stores user authentication tokens and patient ID via [LocalStorageService]
/// - Navigates to the home screen on successful login
/// - Provides a logout method to clear saved tokens
/// - Displays success or error messages using [ScaffoldMessenger]
/// This controller is used with Provider to manage login-related state in a reactive way

class LoginController with ChangeNotifier {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storage = LocalStorageService();

  bool isLoading = false;

  void _setIsLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
  
  bool isFormValid() => formKey.currentState?.validate() ?? false;

  Future<void> login({required BuildContext context}) async {
    if (!isFormValid()) return;
    _setIsLoading(true);

    try {
      final response = await _authRepository.loginUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      final user = response.data.user;
      final access = response.data.access;
      final refresh = response.data.refresh;
      _setIsLoading(false);

      await _storage.init();
      await _storage.saveTokens(access, refresh);
      await _storage.savePatientId(user.id);
      if (context.mounted) {
        _showMessage(context, "Login success: ${response.message}");
      }
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      _setIsLoading(false);
      if (context.mounted) {
        _showMessage(context, "Login failed: ${e.toString()}");
      }
    }
  }

  Future<void> logout() async {
    await _storage.init();
    await _storage.clearTokens();
    // or reset state
  }

  void _showMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
