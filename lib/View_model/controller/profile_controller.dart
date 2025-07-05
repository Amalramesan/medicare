import 'package:flutter/material.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/data/response/api_response.dart';
import 'package:med_care/repository/profile_resporitary.dart';

class ProfileController with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  final LocalStorageService _storage = LocalStorageService();

  ApiResponse<ProfileModel> _profileResponse = ApiResponse.loading();

  ApiResponse<ProfileModel> get profileResponse => _profileResponse;

  String get userName => _profileResponse.data?.data.name ?? 'User';
  String get email => _profileResponse.data?.data.email ?? '';
  String get phone => _profileResponse.data?.data.phoneNumber ?? '';
  String get place => _profileResponse.data?.data.place ?? '';

  Future<void> loadUserProfile() async {
    _profileResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final fetchedProfile = await _profileRepository.fetchUserProfile();

      if (fetchedProfile != null) {
        _profileResponse = ApiResponse.completed(fetchedProfile);
      } else {
        _profileResponse = ApiResponse.error('Failed to load profile');
      }
    } catch (e) {
      final errorMsg = e.toString();

      if (errorMsg.contains('token_not_valid') || errorMsg.contains('Token is expired')) {
        await _storage.clearTokens();
        _profileResponse = ApiResponse.error("Session expired. Please login again.");
      } else {
        _profileResponse = ApiResponse.error("Error: $errorMsg");
      }
    }

    notifyListeners();
  }
}
