class PaymentInfoModel {
  final String? qrImage;
  final String? instructions;

  PaymentInfoModel({
    this.qrImage,
    this.instructions,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      qrImage: json['qrImage'],
      instructions: json['instructions'],
    );
  }
}

class PaymentModel {
  final int id;
  final int userId;
  final int courseId;
  final num amount;
  final String status;
  final String? adminNote;
  final DateTime? reviewedAt;
  final DateTime createdAt;
  final String receiptUrl;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.amount,
    required this.status,
    this.adminNote,
    this.reviewedAt,
    required this.createdAt,
    required this.receiptUrl,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      amount: json['amount'],
      status: json['status'],
      adminNote: json['adminNote'],
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      receiptUrl: json['receiptUrl'],
    );
  }
}
