import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_first_app/data/models/payment_model.dart';

class PaymentService {
  String baseUrl =
      'https://bdsp3fzt-3000.euw.devtunnels.ms/api';

  Future<PaymentInfoModel> getPaymentInfo() async {
    final url = Uri.parse('$baseUrl/payment-info');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return PaymentInfoModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('حدث خطأ');
    }
  }

  Future<PaymentModel> uploadReceipt({
    required int courseId,
    required String token,
    required String filePath,
  }) async {
    final url = Uri.parse(
      '$baseUrl/courses/$courseId/payments',
    );

    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath(
        'receipt',
        filePath,
      ),
    );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    if (response.statusCode == 201) {
      return PaymentModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      final data = jsonDecode(response.body);

      throw Exception(
        data['message'] ?? 'حدث خطأ أثناء رفع الإيصال',
      );
    }
  }
}
