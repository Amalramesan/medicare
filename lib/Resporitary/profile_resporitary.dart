import 'dart:developer';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Res/app_url.dart';

class ProfileRepository {
  final _apiService = NetworkApiService();

  Future<ProfileModel?> fetchUserProfile({required String token}) async {
    try {
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
