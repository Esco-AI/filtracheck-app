import 'package:flutter/material.dart';
import '../../chemical_dictionary/screens/chemical_dictionary_screen.dart';
import '../../chemical_dictionary/widgets/frosted.dart';
import '../../calculator/screens/calculator_intro_screen.dart';
import 'feature_tile.dart';

class FeaturePanel extends StatelessWidget {
  const FeaturePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Frosted(
      borderRadius: 20,
      blur: 16,
      tint: Colors.white.withValues(alpha: 0.06),
      border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const gap = 8.0;
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ChemicalDictionaryScreen(),
                    ),
                  );
                },
              ),
              FeatureTile(
                icon: Icons.inventory_2_rounded,
                label: 'Catalog',
                width: itemWidth,
              ),
              FeatureTile(
                icon: Icons.contact_mail_rounded,
                label: 'Contact',
                width: itemWidth,
              ),
              FeatureTile(
                icon: Icons.rss_feed_rounded,
                label: 'Newsfeed',
                width: itemWidth,
              ),
              FeatureTile(
                icon: Icons.help_center_rounded,
                label: 'FAQ',
                width: itemWidth,
              ),
            ];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i != items.length - 1) const SizedBox(width: gap),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
