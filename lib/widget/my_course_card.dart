import 'package:flutter/material.dart';
import 'package:my_first_app/data/models/my_course_model.dart';

class MyCourseCard extends StatelessWidget {
  final MyCourseModel course;

  const MyCourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFEDF4FC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              course.title,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF103D70),
              ),
            ),

            const SizedBox(height: 10),

            _Info(Icons.person_outline, course.instructor),
            _Info(Icons.location_on_outlined, course.location),
            _Info(Icons.calendar_month_outlined, course.schedule),

            const Divider(
              height: 16,
              color: Color(0xFF103D70),
            ),

            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'السعر: \$${course.price}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  course.enrolledAt.toString().split(' ')[0],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF344054),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _Info(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xFF155BA6),
          ),
          SizedBox(width: 8,),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF102D50),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
