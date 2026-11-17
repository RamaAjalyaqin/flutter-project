import 'package:flutter/material.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/widget/guest_view.dart';
import 'package:my_first_app/widget/profile_view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onCoursesTap;

  const ProfileScreen({
    super.key,
    required this.onCoursesTap,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final isLoggedIn =
        authProvider.token != null &&
        authProvider.token!.isNotEmpty;

    return Scaffold(
      body: isLoggedIn
          ? ProfileView(onCoursesTap: onCoursesTap)
          : const GuestView(),
    );
  }
}