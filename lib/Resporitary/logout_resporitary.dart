import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/logout_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogoutRepository {
  final _apiService = NetworkApiService();

  Future<LogoutModel?> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');

    if (accessToken == null || refreshToken == null) {
      throw Exception('Missing token(s).');
    }

    try {
      final response = await _apiService.getPostApiResponse(
        AppUrl.logoutt,
        {"refresh": refreshToken},
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      return LogoutModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
