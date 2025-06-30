import 'package:flutter/material.dart';
import 'package:med_care/Resporitary/logout_resporitary.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/Models/logout_model.dart';

class LogoutController extends ChangeNotifier {
  final AuthLogoutRepository _logoutRepository = AuthLogoutRepository();
  final LocalStorageService _storage = LocalStorageService();

  bool _isLoading = false;
  String? _error;
  LogoutModel? _logoutModel;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> logout(BuildContext context) async {
    _setLoading(true);
    _error = null;

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

      _logoutModel = result;


      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }
    } catch (e) {
      _error = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logout failed: $_error")),
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
