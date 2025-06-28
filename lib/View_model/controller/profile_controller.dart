// lib/View_model/profile_controller.dart

import 'package:flutter/material.dart';
import 'package:med_care/Models/profile_model.dart';
import 'package:med_care/Resporitary/profile_resporitary.dart';

class ProfileController with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileModel? _profile;

  ProfileModel? get profile => _profile;
  String get userName => _profile?.data.name ?? 'User';
  String get email => _profile?.data.email ?? '';
  String get phone => _profile?.data.phoneNumber ?? '';
  String get place => _profile?.data.place ?? '';

  Future<void> loadUserProfile() async {
    final fetchedProfile = await _profileRepository.fetchUserProfile();
    if (fetchedProfile != null) {
      _profile = fetchedProfile;
      notifyListeners();
    }
  }
}
