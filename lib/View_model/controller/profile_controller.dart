import 'package:flutter/material.dart';
import 'package:med_care/models/profile_model.dart';

import 'package:med_care/data/response/api_response.dart';
import 'package:med_care/repository/profile_resporitary.dart';

class ProfileController with ChangeNotifier {
  ///controller for managing the profile of the user
  ProfileController() {
    loadUserProfile();
  }
  ApiResponse<ProfileModel> profileResponse = ApiResponse.loading();

  String _error = "";
  String get error => _error;
  void _setError(String v) {
    _error = v;
    notifyListeners();
  }

  void _setProfileResponse(ApiResponse<ProfileModel> response) {
    profileResponse = response;
    notifyListeners();
  }

  Future<void> loadUserProfile() async {
    _setError("");
    _setProfileResponse(ApiResponse.loading());

    ProfileRepository.fetchUserProfile()
        .then((v) {
          _setError("");
          _setProfileResponse(ApiResponse.completed(v));
        })
        .onError((e, s) {
          _setError(e.toString());
          _setProfileResponse(ApiResponse.error(e.toString()));
        });
  }
}
