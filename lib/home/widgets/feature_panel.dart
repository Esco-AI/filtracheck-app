import 'package:flutter/material.dart';
import '../../calculator/screen/calculator_intro_screen.dart';
import 'feature_tile.dart';

class FeaturePanel extends StatelessWidget {
  const FeaturePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = 6.0;
          final totalGap = gap * 5;
          final itemWidth = (constraints.maxWidth - totalGap) / 6;

          final items = <Widget>[
            FeatureTile(
              icon: Icons.calculate_rounded,
              label: 'Calculator',
              width: itemWidth,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CalculatorIntroScreen(),
                  ),
                );
              },
            ),
            FeatureTile(
              icon: Icons.science_rounded,
              label: 'Chemical\nDictionary',
              width: itemWidth,
              onTap: () {},
            ),
            FeatureTile(
              icon: Icons.inventory_2_rounded,
              label: 'Catalog',
              width: itemWidth,
              onTap: () {},
            ),
            FeatureTile(
              icon: Icons.contact_mail_rounded,
              label: 'Contact',
              width: itemWidth,
              onTap: () {},
            ),
            FeatureTile(
              icon: Icons.rss_feed_rounded,
              label: 'Newsfeed',
              width: itemWidth,
              onTap: () {},
            ),
            FeatureTile(
              icon: Icons.help_center_rounded,
              label: 'FAQ',
              width: itemWidth,
              onTap: () {},
            ),
          ];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          );
        },
      ),
    );
  }
}
