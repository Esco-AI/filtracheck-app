import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,

          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),

          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
