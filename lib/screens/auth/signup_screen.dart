import 'package:flutter/material.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/screens/main_screen.dart';
import 'package:my_first_app/widget/information_feild.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:
        Text('يرجى تعبئة الحقول المطلوبة',
        style: TextStyle(
          color: Colors.white
        ),
        textDirection:TextDirection.rtl,
        ),
        
        backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:
        Text('كلمتا المرور غير متطابقتين',
        style: TextStyle(
          color: Colors.white,
        ),
        textDirection:TextDirection.rtl,
        ),
        backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success = await authProvider.register(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.error ?? 'حدث خطأ أثناء إنشاء الحساب',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(
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
                    boxShadow:[
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
                        SizedBox(height: 50),

                        Text(
                          'إنشاء حساب جديد',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0xFF023E8A),
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'أدخل بياناتك لإنشاء حسابك',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: Color(0xFF78909C),
                          ),
                        ),

                        SizedBox(height: 25),

                        InformationField(
                          hintText: 'الاسم الكامل',
                          icon: Icons.person,
                          controller: _nameController,
                        ),

                        SizedBox(height: 15),

                        InformationField(
                          hintText: '********09',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                        ),

                        SizedBox(height: 15),

                        InformationField(
                          hintText: 'البريد الإلكتروني',
                          icon: Icons.email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),

                        SizedBox(height: 15),

                        InformationField(
                          hintText: 'كلمة المرور',
                          icon: Icons.lock_outline,
                          obscureText: _hidePassword,
                          controller: _passwordController,
                          onTogglePassword: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),

                        SizedBox(height: 15),

                        InformationField(
                          hintText: 'تأكيد كلمة المرور',
                          icon: Icons.lock_reset,
                          obscureText: _hideConfirmPassword,
                          controller: _confirmPasswordController,
                          onTogglePassword: () {
                            setState(() {
                              _hideConfirmPassword =
                                  !_hideConfirmPassword;
                            });
                          },
                        ),

                        SizedBox(height: 20),

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
                          child: Consumer<AuthProvider>(
                            builder: (context, auth, child) {
                              return TextButton(
                                onPressed: auth.isLoading ? null : _signup,
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
                                child: auth.isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'إنشاء الحساب',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              );
                            },
                          ),
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
