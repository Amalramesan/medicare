import 'dart:developer';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/models/profile_model.dart';
import 'package:med_care/Res/app_url.dart';
//used to handle profile related api calls
class ProfileRepository {
  static final BaseApiService _apiService = NetworApiService();

  static Future<ProfileModel> fetchUserProfile() async {
    try {
      final responseJson = await _apiService.getApi(
        endPoint: AppUrl.profile,
        isAuth: true,
      );
      return ProfileModel.fromJson(responseJson);
    } catch (e) {
      log("Error fetching profile: $e");
      rethrow;
    }
  }
}
