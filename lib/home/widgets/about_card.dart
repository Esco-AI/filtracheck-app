import 'package:flutter/material.dart';
import '../../chemical_dictionary/widgets/frosted.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Frosted(
      borderRadius: 20,
      blur: 16,
      tint: Colors.white, // Changed to white
      border: Border.all(color: Colors.grey.shade300), // Adjusted border
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + accent bar
            Row(
              children: [
                Text(
                  'About the App',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black87, // Changed for visibility
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade200, height: 1),
            const SizedBox(height: 12),
            Text(
              "Esco’s FiltraCheck™ is a free chemical assessment guide dedicated to help you select the right filter for your intended.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
