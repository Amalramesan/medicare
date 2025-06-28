import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';

class RegisterController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _error;
  RegisterModel? _registeredUser;

  String? _genderValue;

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

  Future<void> register(User user, BuildContext context) async {
    _setLoading(true);

    try {
      final response = await _authRepository.registerUser(user);
      _registeredUser = response;

      _setLoading(false);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration success: ${response.message}")),
        );
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      _setLoading(false);
      _error = e.toString();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: $_error")),
        );
      }
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
