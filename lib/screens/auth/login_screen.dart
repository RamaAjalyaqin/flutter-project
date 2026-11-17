import 'package:flutter/material.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/screens/auth/signup_screen.dart';
import 'package:my_first_app/screens/main_screen.dart';
import 'package:my_first_app/widget/information_feild.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool _hidePassword = true;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (phoneController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى إدخال رقم الهاتف وكلمة المرور',
            style: TextStyle(
              color: Colors.white
            ),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<AuthProvider>();

    final success = await provider.login(
      phoneController.text.trim(),
      passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
          ),
          (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

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

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 300),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Color(0xFF155BA6),
                    ),
                  ),
                ),

                Container(
                  height: 600,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26155BA6),
                        blurRadius: 24,
                        spreadRadius: 1,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 45),

                        Image.asset(
                          'assets/images/Syrian Computer Society Logo.png',
                          width: 150,
                          height: 150,
                        ),

                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF023E8A),
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'قم بتسجيل الدخول للوصول الى حسابك',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Color(0xFF78909C),
                          ),
                        ),

                        SizedBox(height: 20),

                        InformationField(
                          hintText: 'رقم الهاتف',
                          icon: Icons.phone_android_rounded,
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                        ),

                        SizedBox(height: 10),

                        InformationField(
                          hintText: 'كلمة المرور',
                          icon: Icons.lock_outline,
                          obscureText: _hidePassword,
                          controller: passwordController,
                          onTogglePassword: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),

                        SizedBox(height: 20),

                        if (provider.error != null)
                          Text(
                            provider.error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Tajawal',
                              fontSize: 12,
                            ),
                          ),

                        SizedBox(height: 12),

                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF0077B6),
                                Color(0xFF023E8A),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: TextButton(
                            onPressed: provider.isLoading
                                ? null
                                : _onLogin,

                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),

                            child: provider.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            const Text(
                              'ليس لديك حساب؟',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                color: Color(0xFF78909C),
                              ),
                            ),

                            SizedBox(width: 2),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen(),
                                  ),
                                );
                              },

                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),

                              child: const Text(
                                'إنشاء حساب جديد',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 12,
                                  color: Color(0xFF155BA6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
