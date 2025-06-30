import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';

class RegisterController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storageService = LocalStorageService();

  // UI state
  bool _isLoading = false;
  String? _error;
  RegisterModel? _registeredUser;
  String? _genderValue;

  // Form & controllers
  GlobalKey<FormState>? formKey;
  TextEditingController? nameController,
      emailController,
      phoneController,
      passwordController,
      confirmPasswordController,
      ageController,
      placeController;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  RegisterModel? get registeredUser => _registeredUser;
  String? get genderValue => _genderValue;

  // Setters
  void setGenderValue(String? value) {
    _genderValue = value;
    notifyListeners();
  }

  void setFormKey(GlobalKey<FormState> key) {
    formKey = key;
  }

  void setControllers({
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController phone,
    required TextEditingController password,
    required TextEditingController confirmPassword,
    required TextEditingController age,
    required TextEditingController place,
  }) {
    nameController = name;
    emailController = email;
    phoneController = phone;
    passwordController = password;
    confirmPasswordController = confirmPassword;
    ageController = age;
    placeController = place;
  }

  /// Register user and save locally after success
  Future<void> register(User user, BuildContext context) async {
    _setLoading(true);
    _error = null;

    try {
      final response = await _authRepository.registerUser(user);
      _registeredUser = response;

      // Save to local storage
      final userData = response.data;
      await _storageService.saveUserName(userData.name);
      await _storageService.saveRegisteredUser(
        name: userData.name,
        email: userData.email,
        place: userData.place,
        phoneNumber: userData.phoneNumber,
      );

      _showMessage(context, "Registration success: ${response.message}");
      if (context.mounted) {
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      _error = e.toString();
      _showMessage(context, "Registration failed: $_error");
    } finally {
      _setLoading(false);
    }
  }

  /// Show snack message
  void _showMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
