class MyCourseModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String instructor;
  final num price;
  final String location;
  final String schedule;
  final DateTime startDate;
  final DateTime endDate;
  final int? seats;
  final String? image;
  final bool isPublished;
  final DateTime enrolledAt;

  MyCourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.price,
    required this.location,
    required this.schedule,
    required this.startDate,
    required this.endDate,
    this.seats,
    this.image,
    required this.isPublished,
    required this.enrolledAt,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      instructor: json['instructor'],
      price: json['price'],
      location: json['location'],
      schedule: json['schedule'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      seats: json['seats'],
      image: json['image'],
      isPublished: json['isPublished'],
      enrolledAt: DateTime.parse(json['enrolledAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'instructor': instructor,
      'price': price,
      'location': location,
      'schedule': schedule,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'seats': seats,
      'image': image,
      'isPublished': isPublished,
      'enrolledAt': enrolledAt.toIso8601String(),
    };
  }
}
