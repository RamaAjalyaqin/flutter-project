import 'package:flutter/material.dart';
import 'package:my_first_app/screens/courses/courses_screen.dart';
import 'package:my_first_app/screens/courses/my_courses_screen.dart';
import 'package:my_first_app/screens/profile/profile_screen.dart';
import 'package:my_first_app/widget/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
    ProfileScreen(
      onCoursesTap: () {
      setState(() {
      selectedIndex = 1;
      });
      },
    ),
    CoursesScreen(),
    MyCoursesScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}