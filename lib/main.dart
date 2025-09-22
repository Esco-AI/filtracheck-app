import 'package:flutter/material.dart';
import 'home/screens/home_screen.dart';

void main() {
  runApp(const FiltraCheckApp());
}

class FiltraCheckApp extends StatelessWidget {
  const FiltraCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
