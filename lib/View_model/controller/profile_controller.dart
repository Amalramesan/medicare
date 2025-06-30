import 'package:flutter/material.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Resporitary/profile_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';

class ProfileController with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  final LocalStorageService _storage = LocalStorageService();

  ProfileModel? _profile;

  ProfileModel? get profile => _profile;
  String get userName => _profile?.data.name ?? 'User';
  String get email => _profile?.data.email ?? '';
  String get phone => _profile?.data.phoneNumber ?? '';
  String get place => _profile?.data.place ?? '';

  Future<void> loadUserProfile() async {
    final token = _storage.accessToken;

    if (token == null) {
      debugPrint('Access token not found');
      return;
    }

    final fetchedProfile = await _profileRepository.fetchUserProfile(token: token);
    if (fetchedProfile != null) {
      _profile = fetchedProfile;
      notifyListeners();
    }
  }
}
