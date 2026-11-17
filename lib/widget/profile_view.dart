import 'package:flutter/material.dart';
import 'package:my_first_app/providers/auth_provider.dart';
import 'package:my_first_app/screens/profile/edit_profile_screen.dart';
import 'package:my_first_app/screens/welcome_screen.dart';
import 'package:my_first_app/widget/menu_item.dart';
import 'package:my_first_app/widget/profile_background.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  final VoidCallback onCoursesTap;

  const ProfileView({
    super.key,
    required this.onCoursesTap,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
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
        ),

        ProfileBackground(),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: provider.fetchUser,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 30),

                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 170,
                          width: 320,
                          margin: const EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A155BA6),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${provider.user?.name}',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${provider.user?.email}',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

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
                      ],
                    ),

                    SizedBox(height: 20),

                    MenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'تعديل الملف الشخصي',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EditProfileScreen(),
                          ),
                        );
                      },
                    ),

                    MenuItem(
                      icon: Icons.workspace_premium_rounded,
                      title: 'شهاداتي',
                      onTap: widget.onCoursesTap,
                    ),

                    MenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'مساعدة',
                      onTap: () {},
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: 320,
                      height: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5F5),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFFFDADA),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).logout();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Color(0xFFD64545),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'تسجيل الخروج',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 14,
                                  color: Color(0xFFD64545),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
