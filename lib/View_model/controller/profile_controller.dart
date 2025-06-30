import 'package:flutter/material.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Resporitary/profile_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/data/response/api_response.dart';

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

    final token = _storage.accessToken;

    if (token == null) {
      _profileResponse = ApiResponse.error('Access token not found');
      notifyListeners();
      return;
    }

    try {
      final fetchedProfile = await _profileRepository.fetchUserProfile(token: token);

      if (fetchedProfile != null) {
        _profileResponse = ApiResponse.completed(fetchedProfile);
      } else {
        _profileResponse = ApiResponse.error('Failed to load profile');
      }
    } catch (e) {
      _profileResponse = ApiResponse.error("Error: ${e.toString()}");
    }

    notifyListeners();
  }
}
