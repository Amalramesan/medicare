import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/logout_model.dart';
import 'package:med_care/Res/app_url.dart';

class AuthLogoutRepository {
  final _apiService = NetworkApiService();

  Future<LogoutModel?> logout({
    required String accessToken,
    required String refreshToken,
  }) async {
    final response = await _apiService.getPostApiResponse(
      AppUrl.logoutt,
      {"refresh": refreshToken},
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    return LogoutModel.fromJson(response);
  }
}
