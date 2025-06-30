import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Resporitary/auth_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/data/response/api_response.dart';

class RegisterController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storageService = LocalStorageService();

ApiResponse<RegisterModel> _registerResponse = ApiResponse.loading();
ApiResponse<RegisterModel> get registerResponse => _registerResponse;
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
  _registerResponse = ApiResponse.loading();
  notifyListeners();

  try {
    final response = await _authRepository.registerUser(user);
    _registerResponse = ApiResponse.completed(response);
    notifyListeners();

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
    _registerResponse = ApiResponse.error(e.toString());
    notifyListeners();
    _showMessage(context, "Registration failed: ${e.toString()}");
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

}
