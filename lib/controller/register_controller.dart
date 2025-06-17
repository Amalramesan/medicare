import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/utilities/tokens.dart';

class RegisterContrller extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  bool _isLoading = false;
  String? _error;
  RegisterModel? _regsteredUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  RegisterModel? get regsteredUser => _regsteredUser;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration success:${response.message}")),
      );
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration failed:$_error")));
    }
  }
}
