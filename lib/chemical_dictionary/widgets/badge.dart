import 'package:flutter/material.dart';
import 'frosted.dart';

class BadgePill extends StatelessWidget {
  final String text;
  const BadgePill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Frosted(
      borderRadius: 999,
      blur: 8,
      tint: Colors.grey.shade200,
      border: Border.all(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
