import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top image
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Ink.image(
              image: const AssetImage(
                'assets/images/cvd-19.jpg', // placeholder
              ),
              fit: BoxFit.cover,
              child: InkWell(onTap: () {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Into the Genome: COVID-19 Diagnostics',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Controlling the spread of a disease outbreak requires an accurate understanding of the causative agent, transmission mechanisms, patient profiles, and available interventions...',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: 140,
              height: 38,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Read More'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
