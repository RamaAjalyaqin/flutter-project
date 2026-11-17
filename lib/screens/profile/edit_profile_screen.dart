import 'package:flutter/material.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/providers/edit_profile_provider.dart';
import 'package:my_first_app/widget/information_feild.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _hideCurrentPassword = true;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProfile();
    });
  }

  Future<void> _getProfile() async {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    if (authProvider.token == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final success = await profileProvider.getProfile(
      authProvider.token!,
    );

    if (!mounted) return;

    if (success && profileProvider.user != null) {
      final user = profileProvider.user!;

      _nameController.text = user.name;
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phone;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            profileProvider.error ??
                'حدث خطأ أثناء جلب البيانات',
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Tajawal',
            ),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveChanges() async {
    if (_isSaving) return;

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى إدخال الاسم ورقم الهاتف',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.isNotEmpty ||
        _confirmPasswordController.text.isNotEmpty ||
        _currentPasswordController.text.isNotEmpty) {
      if (_currentPasswordController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'يرجى تعبئة حقول كلمات المرور الثلاثة',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_passwordController.text !=
          _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'كلمتا المرور غير متطابقتين',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (authProvider.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب تسجيل الدخول أولاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final profileSuccess =
          await profileProvider.updateProfile(
        token: authProvider.token!,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      if (!mounted) return;

      if (!profileSuccess || profileProvider.user == null) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              profileProvider.error ??
                  'حدث خطأ أثناء تعديل البيانات',
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontFamily: 'Tajawal',
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      authProvider.updateLocalUser(
        profileProvider.user!,
      );

      if (_passwordController.text.isNotEmpty) {
        final passwordSuccess =
            await profileProvider.changePassword(
          token: authProvider.token!,
          currentPassword: _currentPasswordController.text,
          newPassword: _passwordController.text,
        );

        if (!mounted) return;

        if (!passwordSuccess) {
          setState(() {
            _isSaving = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                profileProvider.error ??
                    'حدث خطأ أثناء تغيير كلمة المرور',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم حفظ التعديلات بنجاح',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Tajawal',
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ: $e',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0FAFF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Color(0xFF155BA6),
          ),
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تعديل الملف الشخصي',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF023E8A),
            ),
          ),
        ),
      ),
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
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF155BA6),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          const CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xFFD4E8F2),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF023E8A),
                                size: 90,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 90,
                              top: 70,
                            ),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: const Color(0xFF155BA6),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'تعديل الصورة الشخصية',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: 400,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),

                              const Padding(
                                padding: EdgeInsets.only(left: 100),
                                child: Text(
                                  'تعديل المعلومات الشخصية',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF155BA6),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              InformationField(
                                hintText: 'الاسم الكامل',
                                icon: Icons.person,
                                controller: _nameController,
                                verticalPanding: 10,
                              ),

                              const SizedBox(height: 15),

                              InformationField(
                                hintText: 'البريد الإلكتروني',
                                icon: Icons.email_rounded,
                                controller: _emailController,
                                keyboardType:
                                    TextInputType.emailAddress,
                                verticalPanding: 10,
                              ),

                              const SizedBox(height: 15),

                              InformationField(
                                hintText: 'رقم الهاتف',
                                icon: Icons.phone_outlined,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                verticalPanding: 10,
                              ),

                              const SizedBox(height: 15),

                              InformationField(
                                hintText: 'كلمة المرور الحالية',
                                icon: Icons.lock_outline,
                                controller:
                                    _currentPasswordController,
                                verticalPanding: 10,
                                obscureText: _hideCurrentPassword,
                                onTogglePassword: () {
                                  setState(() {
                                    _hideCurrentPassword =
                                        !_hideCurrentPassword;
                                  });
                                },
                              ),

                              const SizedBox(height: 15),

                              InformationField(
                                hintText: 'كلمة المرور الجديدة',
                                icon: Icons.lock_outline,
                                controller: _passwordController,
                                verticalPanding: 10,
                                obscureText: _hidePassword,
                                onTogglePassword: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                              ),

                              const SizedBox(height: 15),

                              InformationField(
                                hintText: 'تأكيد كلمة المرور',
                                icon: Icons.lock_reset,
                                controller:
                                    _confirmPasswordController,
                                verticalPanding: 10,
                                obscureText: _hideConfirmPassword,
                                onTogglePassword: () {
                                  setState(() {
                                    _hideConfirmPassword =
                                        !_hideConfirmPassword;
                                  });
                                },
                              ),

                              const SizedBox(height: 27),

                              Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF155BA6),
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(30),
                                    onTap: _isSaving
                                        ? null
                                        : _saveChanges,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (_isSaving)
                                          const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                                CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        else
                                          const Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        const SizedBox(width: 12),
                                        Text(
                                          _isSaving
                                              ? 'جاري الحفظ...'
                                              : 'حفظ التعديلات',
                                          style: const TextStyle(
                                            fontFamily: 'Tajawal',
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF155BA6),
                                    width: 1.5,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(30),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Center(
                                      child: Text(
                                        'إلغــــــــــــــــــــاء',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 16,
                                          color: Color(0xFF155BA6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),
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
