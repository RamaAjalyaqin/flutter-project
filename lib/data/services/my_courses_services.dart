import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/data/models/my_course_model.dart';

class MyCoursesService {
  String baseUrl = 'https://bdsp3fzt-3000.euw.devtunnels.ms/api';

  Future<List<MyCourseModel>> getMyCourses(String token) async {
    final url = Uri.parse('$baseUrl/me/courses');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((item) => MyCourseModel.fromJson(item)).toList();
    } else {
      throw Exception('خطأ في السيرفر');
    }
  }
}
