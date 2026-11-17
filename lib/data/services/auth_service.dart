import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_first_app/data/models/auth_model.dart';

class AuthService {
  final String baseUrl =
      'https://bdsp3fzt-3000.euw.devtunnels.ms/api';

  Future<LoginResponse> login(
    String phone,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return LoginResponse.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception('رقم الهاتف أو كلمة المرور غير صحيحة');
  }

  Future<LoginResponse> register({
    required String name,
    required String phone,
    String? email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        if (email != null && email.trim().isNotEmpty)
          'email': email.trim(),
        'password': password,
      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return LoginResponse.fromJson(
        jsonDecode(response.body),
      );
    }

    String message = 'حدث خطأ أثناء إنشاء الحساب';

    try {
      final data = jsonDecode(response.body);
      message = data['message'] ?? message;
    } catch (_) {}

    throw Exception(message);
  }

  Future<UserModel> getCurrentUser(String token) async {
    final url = Uri.parse('$baseUrl/auth/me');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return UserModel.fromJson(
        data['user'] ?? data,
      );
    }

    throw Exception('فشل في جلب بيانات المستخدم');
  }
}
