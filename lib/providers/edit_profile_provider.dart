import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/auth_model.dart';
import 'package:my_first_app/data/services/edit_profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _service = ProfileService();

  UserModel? user;

  bool isLoading = false;
  bool isUpdating = false;
  String? error;

  Future<bool> getProfile(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await _service.getProfile(token);
    } catch (e) {
      error = e.toString().replaceFirst(
        'Exception: ',
        '',
      );
    }

    isLoading = false;
    notifyListeners();

    return error == null;
  }

  Future<bool> updateProfile({
    required String token,
    required String name,
    String? email,
    required String phone,
  }) async {
    isUpdating = true;
    error = null;
    notifyListeners();

    try {
      user = await _service.updateProfile(
        token: token,
        name: name,
        email: email,
        phone: phone,
      );
    } catch (e) {
      error = e.toString().replaceFirst(
        'Exception: ',
        '',
      );
    }

    isUpdating = false;
    notifyListeners();

    return error == null;
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    isUpdating = true;
    error = null;
    notifyListeners();

    try {
      await _service.changePassword(
        token: token,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      error = e.toString().replaceFirst(
        'Exception: ',
        '',
      );
    }

    isUpdating = false;
    notifyListeners();

    return error == null;
  }
}
