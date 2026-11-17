import 'package:flutter/material.dart';
import 'package:my_first_app/screens/auth/login_screen.dart';
import 'package:my_first_app/screens/auth/signup_screen.dart';

class GuestView extends StatelessWidget {
  const GuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xFFD4E8F2),
                    child: Icon(
                        Icons.person,
                        color: Color(0xFF023E8A),
                        size: 100,
                        ),
                      ),
                  ),
                SizedBox(height: 25),
                Text(
                  'أهلاً بك',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF023E8A),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'سجّل دخولك حتى تتمكن من الوصول إلى ملفك الشخصي ودوراتك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const LoginScreen(),
                        ),
                     );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF155BA6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 250,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                       ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side:BorderSide(
                        color: Color(0xFF155BA6),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'إنشاء حساب جديد',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Color(0xFF155BA6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}