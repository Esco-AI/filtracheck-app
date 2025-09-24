import 'package:flutter/material.dart';
import '../home/screens/home_screen.dart';

class AppBottomNav extends StatelessWidget {
  final int? activeIndex;
  const AppBottomNav({super.key, this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final bool isAnyItemSelected = activeIndex != null;

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      currentIndex: activeIndex ?? 0,
      onTap: (i) {
        if (i == 0) {
          if (activeIndex != 0) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          }
        }
        // i == 1 will be for the 'About' screen in the future
      },
      selectedItemColor: isAnyItemSelected ? Colors.blue : Colors.grey,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 13,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'About'),
      ],
    );
  }
}
