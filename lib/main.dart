import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home/home_screen.dart';
import 'calculator/calculator_intro_screen.dart';

void main() {
  runApp(const FiltraCheckApp());
}

class FiltraCheckApp extends StatelessWidget {
  const FiltraCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/calculator',
          builder: (context, state) => const CalculatorIntroScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}