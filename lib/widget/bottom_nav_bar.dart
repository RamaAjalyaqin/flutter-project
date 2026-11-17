import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFA5D8F2),

      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0FAFF),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF023E8A).withOpacity(0.12),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),

            child: NavigationBar(
              height: 75,
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,

              backgroundColor: const Color(0xFFF0FAFF),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,

              indicatorColor: const Color(0xFFC8E8F8),

              labelBehavior:
                  NavigationDestinationLabelBehavior.alwaysShow,

              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF023E8A),
                  ),
                  selectedIcon: Icon(
                    Icons.person_rounded,
                    color: Color(0xFF023E8A),
                  ),
                  label: 'حسابي',
                ),

                NavigationDestination(
                  icon: Icon(
                    Icons.library_books_outlined,
                    color: Color(0xFF023E8A),
                  ),
                  selectedIcon: Icon(
                    Icons.library_books_rounded,
                    color: Color(0xFF023E8A),
                  ),
                  label: 'الدورات',
                ),

                NavigationDestination(
                  icon: Icon(
                    Icons.book_outlined,
                    color: Color(0xFF023E8A),
                  ),
                  selectedIcon: Icon(
                    Icons.book_rounded,
                    color: Color(0xFF023E8A),
                  ),
                  label: 'دوراتي',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
