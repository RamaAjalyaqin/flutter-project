import 'package:flutter/material.dart';
import 'package:my_first_app/widget/guest_view.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/providers/my_courses_provider.dart';
import 'package:my_first_app/widget/my_courses_view.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final isLoggedIn = authProvider.token != null && authProvider.token!.isNotEmpty;

    if (isLoggedIn) {
      Provider.of<MyCoursesProvider>(
        context,
        listen: false,
      ).setAuthProvider(authProvider);
    }

   return Scaffold(
  body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFEAF6FC),
          Color(0xFFC8E8F8),
          Color(0xFFA5D8F2),
        ],
      ),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/Syrian Computer Society Logo.png',
                width: 60,
                height: 60,
              ),
              const Text(
                'دوراتي',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF023E8A),
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),

        Expanded(
          child: isLoggedIn
              ? const MyCoursesView()
              : const GuestView(),
        ),
      ],
    ),
  ),
);
  }
}
