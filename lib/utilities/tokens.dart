import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokens(String accessToken, String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
  await prefs.setString('refresh_token', refreshToken);
}

Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

Future<void> clearTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  await prefs.remove('refresh_token');
  await prefs.remove('patient_id'); // optional
  await prefs.remove('user_name');
}

// Save user name
Future<void> saveUserName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', name);
}

Future<String?> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

// Save patient ID
Future<void> savePatientId(int id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('patient_id', id);
}

Future<int?> getPatientId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('patient_id');
}
