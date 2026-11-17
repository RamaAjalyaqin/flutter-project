import 'package:flutter/material.dart';
import 'package:my_first_app/providers/courses_provider.dart';
import 'package:my_first_app/widget/course_card.dart';
import 'package:provider/provider.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {

  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    final filteredCourses = provider.courses.where((course) {
      return course.title.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();

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

        child: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.error != null
                ? Center(
                    child: Text(
                      provider.error!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF023E8A),
                      ),
                    ),
                  )
                : Container(
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
                          padding: const EdgeInsets.only(top: 25,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/Syrian Computer Society Logo.png',
                                width: 60,
                                height: 60,
                              ),
                              Text(
                                'الدورات(${provider.total})',
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

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            controller: searchController,
                            textDirection: TextDirection.rtl,

                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.trim();
                              });
                            },

                            decoration: InputDecoration(
                              hintText: 'البحث عن دورة',
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 13,
                                color: Colors.grey,
                              ),

                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF023E8A),
                              ),

                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        searchController.clear();
                                        setState(() {
                                          searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,

                              filled: true,
                              fillColor: Colors.white,

                              contentPadding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 15,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF0FAFF),
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD4E8F2),
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0077B6),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: provider.courses.isEmpty
                              ? const Center(
                                  child: Text(
                                    'لا توجد كورسات حالياً',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              : filteredCourses.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'لا توجد نتائج للبحث',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF023E8A),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(12),
                                      itemCount: filteredCourses.length,

                                      itemBuilder: (context, index) {
                                        final course =
                                            filteredCourses[index];

                                        return CourseCard(
                                          course: course,
                                          title: course.title,
                                          instructor: course.instructor,
                                          schedule: course.schedule,
                                          location: course.location,
                                          price: course.price.toString(),
                                          seatsLeft: course.seatsLeft,
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
