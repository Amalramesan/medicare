import 'package:shared_preferences/shared_preferences.dart';

/// A singleton service class for managing local storage using SharedPreferences.
/// This service handles storing and retrieving:
/// - Authentication tokens (access, refresh)
/// - Patient/user identifiers
/// - Basic user profile information
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _prefs?.setString('access_token', accessToken);
    await _prefs?.setString('refresh_token', refreshToken);
  }

  String? get accessToken => _prefs?.getString('access_token');
  String? get refreshToken => _prefs?.getString('refresh_token');

  Future<void> clearTokens() async {
    await _prefs?.remove('access_token');
    await _prefs?.remove('refresh_token');
    await _prefs?.remove('patient_id');
    await _prefs?.remove('user_name');
  }

  // Patient ID
  Future<void> savePatientId(int id) async {
    await _prefs?.setInt('patient_id', id);
  }

  int? get patientId => _prefs?.getInt('patient_id');

  // User name
  Future<void> saveUserName(String name) async {
    await _prefs?.setString('user_name', name);
  }

  String? get userName => _prefs?.getString('user_name');

  // Registered User Info
  Future<void> saveRegisteredUser({
    required String name,
    required String email,
    required String place,
    required String phoneNumber,
  }) async {
    await _prefs?.setString('user_name', name);
    await _prefs?.setString('user_email', email);
    await _prefs?.setString('user_place', place);
    await _prefs?.setString('user_phone', phoneNumber);
  }

  Map<String, dynamic> get registeredUser => {
        'name': _prefs?.getString('user_name') ?? '',
        'email': _prefs?.getString('user_email') ?? '',
        'age': _prefs?.getInt('user_age') ?? 0,
        'place': _prefs?.getString('user_place') ?? '',
        'gender': _prefs?.getString('user_gender') ?? '',
        'phone': _prefs?.getString('user_phone') ?? '',
      };
}