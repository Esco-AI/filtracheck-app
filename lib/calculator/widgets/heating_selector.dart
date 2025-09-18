import 'package:flutter/material.dart';

class HeatingSelector extends StatelessWidget {
  final bool involvesHeating;
  final ValueChanged<bool> onChanged;

  const HeatingSelector({
    super.key,
    required this.involvesHeating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = ["Yes", "No"];
    final selectedIndex = involvesHeating ? 0 : 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Does it involve heating?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ToggleButtons(
              isSelected: List.generate(
                options.length,
                (i) => i == selectedIndex,
              ),
              onPressed: (index) {
                onChanged(index == 0); // true for "Yes", false for "No"
              },
              borderRadius: BorderRadius.circular(12),
              borderColor: Colors.white70,
              selectedBorderColor: Colors.white,
              fillColor: Colors.white.withOpacity(0.2),
              selectedColor: Colors.white,
              color: Colors.white70,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
              children: options
                  .map(
                    (label) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(label),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}