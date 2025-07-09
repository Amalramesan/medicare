import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';
import 'package:med_care/repository/auth_resporitary.dart';

class RegisterController with ChangeNotifier {
  ///controller for managing the regristration 
  final formKey = GlobalKey<FormState>();
  /// Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();
  final LocalStorageService _storageService = LocalStorageService();

  String? _genderValue;
  String? get genderValue => _genderValue;

  bool isLoading = false;

  void setGenderValue(String? value) {
    _genderValue = value;
    notifyListeners();
  }

  bool isFormValid() => formKey.currentState?.validate() ?? false;

  Future<void> register(BuildContext context) {
    if (!isFormValid()) return Future.value();

    _setLoading(true);

    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text.trim(),
      confirmpassword: confirmPasswordController.text.trim(),
      age: int.parse(ageController.text.trim()),
      place: placeController.text.trim(),
      gender: _genderValue ?? "",
    );

    return _authRepository
        .registerUser(user)
        .then((response) async {
          final data = response.data;

          await _storageService.saveUserName(data.name);
          await _storageService.saveRegisteredUser(
            name: data.name,
            email: data.email,
            place: data.place,
            phoneNumber: data.phoneNumber,
          );

          if (context.mounted) {
            _showMessage(context, "Registration success: ${response.message}");
            Navigator.pushNamed(context, '/login');
          }
        })
        .catchError((e) {
          if (context.mounted) {
            _showMessage(context, "Registration failed: ${e.toString()}");
          }
        })
        .whenComplete(() {
          _setLoading(false);
        });
  }

  void _setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void _showMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
