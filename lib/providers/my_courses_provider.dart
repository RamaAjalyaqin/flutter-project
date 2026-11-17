import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/my_course_model.dart';
import 'package:my_first_app/data/services/my_courses_services.dart';
import 'package:my_first_app/providers/auth_provider.dart';

class MyCoursesProvider extends ChangeNotifier {
  final MyCoursesService _service = MyCoursesService();

  AuthProvider? _authProvider;

  List<MyCourseModel> myCourses = [];

  bool isLoading = false;
  String? error;

  void setAuthProvider(AuthProvider authProvider) {
    _authProvider = authProvider;
  }

  Future<void> fetchMyCourses() async {
    final token = _authProvider?.token;

    if (token == null || token.isEmpty) {
      myCourses = [];
      error = 'يجب تسجيل الدخول أولاً';
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      myCourses = await _service.getMyCourses(token);
    } catch (e) {
      error = 'حدث خطأ، حاول مرة أخرى';
    }

    isLoading = false;
    notifyListeners();
  }
}
