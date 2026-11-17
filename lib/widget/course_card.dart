import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/courses_model.dart';
import 'package:my_first_app/providers/courses_provider.dart';
import 'package:my_first_app/screens/auth/login_screen.dart';
import 'package:my_first_app/screens/payment_screen.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;

  final String title;
  final String instructor;
  final String schedule;
  final String location;
  final String price;
  final int? seatsLeft;

  const CourseCard({
    super.key,
    required this.course,
    required this.title,
    required this.instructor,
    required this.schedule,
    required this.location,
    required this.price,
    this.seatsLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102D50).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF155BA6),
                    Color(0xFF103D70),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 17,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          instructor,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          '\$$price',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                children: [

                  _info(
                    Icons.calendar_month_rounded,
                    schedule,
                  ),

                  const SizedBox(height: 10),

                  _info(
                    Icons.location_on_outlined,
                    location,
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.event_seat_rounded,
                          color: Colors.green,
                          size: 18,
                        ),

                        const SizedBox(width: 7),

                        const Expanded(
                          child: Text(
                            'المقاعد المتبقية',
                            style: TextStyle(
                              color: Color(0xFF344054),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Text(
                          seatsLeft == null
                              ? 'غير محدد'
                              : '$seatsLeft مقعد',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF155BA6),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            size: 16,
                          ),

                          SizedBox(width: 8),

                          Text(
                            'تسجيل',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(
    IconData icon,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFEDF4FC),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF155BA6),
            size: 17,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF102D50),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
