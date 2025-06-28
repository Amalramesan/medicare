import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:med_care/View_model/services/tokens_and_sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<RegisterModel> registerUser(User user) async {
    final response = await _apiService.getPostApiResponse(
      AppUrl.register,
      user.toJson(),
    );

    final registerModel = RegisterModel.fromJson(response);
    final userData = registerModel.data;

    // Save user data into SharedPreferences
    await saveUserName(userData.name);
    await saveRegisteredUser(
      name: userData.name,
      email: userData.email,
      place: userData.place,
      phoneNumber: userData.phoneNumber,
    );

    return registerModel;
  }

  Future<LoginModel> loginUser(String email, String password) async {
    final response = await _apiService.getPostApiResponse(
      AppUrl.login,
      {'email': email, 'password': password},
    );

    final loginModel = LoginModel.fromJson(response);
    final access = loginModel.data.access;
    final refresh = loginModel.data.refresh;
    final user = loginModel.data.user;

    await saveTokens(access, refresh);
    await savePatientId(user.id);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', access);

    return loginModel;
  }
}
