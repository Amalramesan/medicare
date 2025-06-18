import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/Models/profile_model.dart';

class ProfileController with ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profile => _profile;
  String get userName => _profile?.data.name ?? 'User';
  String get email => _profile?.data.email ?? '';
  String get phone => _profile?.data.phoneNumber ?? '';
  String get place => _profile?.data.place ?? '';

  Future<void> loadUserProfile() async {
    final fetchProfile = await ApiServices().fetchUserProfile();
    if (fetchProfile != null) {
      _profile = fetchProfile;
      notifyListeners();
    }
  }
}
