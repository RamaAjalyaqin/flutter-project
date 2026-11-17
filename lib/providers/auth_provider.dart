import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/auth_model.dart';
import 'package:my_first_app/data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  String? token;
  UserModel? user;

  bool isLoading = false;
  String? error;

  Future<bool> login(
    String phone,
    String password,
  ) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _service.login(
        phone,
        password,
      );

      token = result.token;
      user = result.user;
    } catch (e) {
      error = 'رقم الهاتف أو كلمة المرور غير صحيحة';
    }

    isLoading = false;
    notifyListeners();

    return error == null;
  }

  Future<bool> register({
    required String name,
    required String phone,
    String? email,
    required String password,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _service.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      token = result.token;
      user = result.user;
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

  void logout() {
    token = null;
    user = null;
    error = null;
    notifyListeners();
  }



  Future<void> fetchUser() async {
  final currentToken = token;

  if (currentToken == null || currentToken.isEmpty) {
    error = 'يجب تسجيل الدخول أولاً';
    notifyListeners();
    return;
  }

  isLoading = true;
  error = null;
  notifyListeners();

  try {
    user = await _service.getCurrentUser(currentToken);
  } catch (e) {
    error = 'حدث خطأ، حاول مرة أخرى';
  }

  isLoading = false;
  notifyListeners();
}

void updateLocalUser(UserModel updatedUser) {
  user = updatedUser;
  notifyListeners();
}
}

