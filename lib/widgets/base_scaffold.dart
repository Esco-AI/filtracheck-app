import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: body,
      bottomNavigationBar: AppBottomNav(currentIndex: currentIndex),
    );
  }
}