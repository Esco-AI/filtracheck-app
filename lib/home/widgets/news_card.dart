import 'package:flutter/material.dart';
import '../../chemical_dictionary/widgets/frosted.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Frosted(
      borderRadius: 20,
      blur: 14,
      tint: Colors.white.withValues(alpha: 0.06),
      border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 140,
              width: double.infinity,
              child: Image.asset('assets/images/cvd-19.jpg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Into the Genome: COVID-19 Diagnostics',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Controlling the spread of a disease outbreak requires an accurate understanding of the causative agent, transmission mechanisms, patient profiles, and available interventions...',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              height: 38,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7E57C2),
                        Color(0xFFEC407A),
                      ], // purple → pink
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Read More',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
