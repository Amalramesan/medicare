import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Res/app_url.dart';

class AuthRepository {
  Future<RegisterModel> registerUser(User user) async {
    final url = Uri.parse(AppUrl.register);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Registration failed: ${response.body}");
    }
  }


Future<LoginModel> loginUser(String email, String password) async {
    final url = Uri.parse(AppUrl.login);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> rawJson = jsonDecode(response.body);
      return LoginModel.fromJson(rawJson);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
