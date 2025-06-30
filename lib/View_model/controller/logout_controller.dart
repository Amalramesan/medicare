import 'package:flutter/material.dart';
import 'package:med_care/Resporitary/logout_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/Models/logout_model.dart';
import 'package:med_care/data/response/api_response.dart';

class LogoutController extends ChangeNotifier {
  final AuthLogoutRepository _logoutRepository = AuthLogoutRepository();
  final LocalStorageService _storage = LocalStorageService();
  ApiResponse<LogoutModel> _logoutResponse = ApiResponse.loading();
  ApiResponse<LogoutModel> get logoutResponse => _logoutResponse;

  bool _isLoading = false;
  String? _error;
  LogoutModel? _logoutModel;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> logout(BuildContext context) async {
    _logoutResponse = ApiResponse.loading(); //loading
    notifyListeners();

    try {
      final accessToken = _storage.accessToken;
      final refreshToken = _storage.refreshToken;

      if (accessToken == null || refreshToken == null) {
        throw Exception('Tokens not available');
      }

      final result = await _logoutRepository.logout(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      _logoutResponse = ApiResponse.completed(result);
      notifyListeners();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }
    } catch (e) {
      _logoutResponse = ApiResponse.error(e.toString());
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logout failed: ${e.toString()}")),
        );
      }
    }
  }
}
