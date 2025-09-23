import 'dart:ui';
import 'package:flutter/material.dart';
import '../home/screens/home_screen.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (i) {
              if (i == 0) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              }
              // i == 1 = About (future feature)
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withValues(alpha: 0.6),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            items: [
              _buildItem(
                icon: Icons.home_rounded,
                label: 'Home',
                active: currentIndex == 0,
              ),
              _buildItem(
                icon: Icons.info_rounded,
                label: 'About',
                active: currentIndex == 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required String label,
    required bool active,
  }) {
    final gradient = const LinearGradient(
      colors: [Colors.white, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return BottomNavigationBarItem(
      icon: ShaderMask(
        shaderCallback: (rect) => active
            ? gradient.createShader(rect)
            : const LinearGradient(
                colors: [Colors.white54, Colors.white54],
              ).createShader(rect),
        child: Icon(icon, size: active ? 28 : 24, color: Colors.white),
      ),
      label: label,
    );
  }
}
