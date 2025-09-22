import 'package:flutter/material.dart';

class CalcSectionHeader extends StatelessWidget {
  final String title;
  const CalcSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
