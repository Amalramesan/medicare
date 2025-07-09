import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
///used to handle register and login api calls 
class AuthRepository {
  final BaseApiService _apiService = NetworApiService();
//register
  Future<RegisterModel> registerUser(User user) async {
    try {
      final response = await _apiService.postApi(
        payload: user.toJson(),
        endPoint: AppUrl.register,
        isAuth: false,
      );
      return RegisterModel.fromJson(response);
    } catch (e) {
     rethrow;
    }
  }
//login
  Future<LoginModel> loginUser(String email, String password) async {
    try {
      final response = await _apiService.postApi(
        payload: {'email': email, 'password': password},
        endPoint: AppUrl.login,
        isAuth: false,
      );
      return LoginModel.fromJson(response);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
