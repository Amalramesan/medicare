import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/Services/tokens_and_sharedpref.dart';

class RegisterContrller extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  // Loading & response state
  bool _isLoading = false;
  String? _error;
  RegisterModel? _regsteredUser;

  // Gender
  String? _genderValue;

  // Form & input controllers
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
  RegisterModel? get regsteredUser => _regsteredUser;
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

  // Main register function
  Future<void> register(User user, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      RegisterModel response = await _apiServices.registerUser(user);
      _regsteredUser = response;

      await saveUserName(response.data.name);

      _isLoading = false;
      notifyListeners();
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration success: ${response.message}")),
      );
  Navigator.pushNamed(context, '/login');
     }
     
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: $_error")),
        );
      }
    }
  }
}
