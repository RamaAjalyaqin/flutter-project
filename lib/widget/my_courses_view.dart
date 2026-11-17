import 'package:flutter/material.dart';
import 'package:my_first_app/widget/my_course_card.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/providers/my_courses_provider.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MyCoursesProvider>(context, listen: false).fetchMyCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCoursesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.myCourses.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.error != null && provider.myCourses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error!),
              ],
            ),
          );
        }

        if (provider.myCourses.isEmpty) {
          return const Center(
            child: Text('لا يوجد لديك كورسات حالياً'),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.fetchMyCourses,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.myCourses.length,
            itemBuilder: (context, index) {
              return MyCourseCard(
                course: provider.myCourses[index],
              );
            },
          ),
        );
      },
    );
  }
}
