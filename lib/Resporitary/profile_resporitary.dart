import 'dart:developer';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Res/app_url.dart';

class ProfileRepository {
  final BaseApiService _apiService = NetworApiService();

  Future<ProfileModel?> fetchUserProfile() async {
    try {
      final responseJson = await _apiService.getApi(
        endPoint: AppUrl.profile,
        isAuth: true, // Adds Authorization header internally
      );
      return ProfileModel.fromJson(responseJson);
    } catch (e) {
      log("Error fetching profile: $e");
      return null;
    }
  }
}
