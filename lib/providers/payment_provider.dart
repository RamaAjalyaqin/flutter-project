import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/payment_model.dart';
import 'package:my_first_app/data/services/payment_services.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service = PaymentService();

  PaymentInfoModel? paymentInfo;
  PaymentModel? payment;

  bool isLoading = false;
  bool isUploading = false;

  String? error;

  Future<void> fetchPaymentInfo() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      paymentInfo = await _service.getPaymentInfo();
    } catch (e) {
      error = 'حدث خطأ في جلب معلومات الدفع';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> uploadReceipt({
    required int courseId,
    required String token,
    required String filePath,
  }) async {
    isUploading = true;
    error = null;
    notifyListeners();

    try {
      payment = await _service.uploadReceipt(
        courseId: courseId,
        token: token,
        filePath: filePath,
      );

      isUploading = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');

      isUploading = false;
      notifyListeners();

      return false;
    }
  }
}
