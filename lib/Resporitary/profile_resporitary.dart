
import 'dart:developer';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final _apiService = NetworkApiService();

  Future<ProfileModel?> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      if (token == null) {
        log("Access token not found");
        return null;
      }

      final responseJson = await _apiService.getGetApiResponse(
        AppUrl.profile,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return ProfileModel.fromJson(responseJson);
    } catch (e) {
      log("Error fetching profile: $e");
      return null;
    }
  }
}
