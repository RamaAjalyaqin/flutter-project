import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_first_app/data/models/auth_model.dart';

class ProfileService {
  final String baseUrl ='https://bdsp3fzt-3000.euw.devtunnels.ms/api';

  Future<UserModel> getProfile(
    String token,
  ) async {
    final url = Uri.parse('$baseUrl/me');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception('حدث خطأ');
  }

  Future<UserModel> updateProfile({
    required String token,
    required String name,
    String? email,
    required String phone,
  }) async {
    final url = Uri.parse('$baseUrl/me');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'email': email == null || email.trim().isEmpty
        ? null
        : email.trim(),
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    }

    String message = 'حدث خطأ أثناء التعديل ';

    try {
      final data = jsonDecode(response.body);
      message = data['message'] ?? message;
    } catch (_) {}

    throw Exception(message);
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/me/password');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }

    String message = 'حدث خطأ أثناء تغيير كلمة المرور';

    try {
      final data = jsonDecode(response.body);
      message = data['message'] ?? message;
    } catch (_) {}

    throw Exception(message);
  }
}
