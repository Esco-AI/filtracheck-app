import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationScreen({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final bool isDucted = recommendation['isDucted'];
    final List<String> reasons = recommendation['reasons'];
    final String? mainFilter = recommendation['mainFilter'];
    final String? secondaryFilter = recommendation['secondaryFilter'];
    final List<String> unsupportedFilters =
        recommendation['unsupportedFilters'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fume Hood Recommendation'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDucted
                        ? 'Ducted Fume Hood Recommended'
                        : 'Ductless Fume Hood Recommended',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (reasons.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'Reason(s):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    for (final reason in reasons) Text('• $reason'),
                  ],
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  if (!isDucted) ...[
                    const Text(
                      'Proposed Cartridge Set:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildFilterRow(
                      'Main Filter:',
                      mainFilter ?? 'Not required',
                    ),
                    _buildFilterRow(
                      'Secondary Filter:',
                      secondaryFilter ?? 'Not required',
                    ),
                    if (unsupportedFilters.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Unsupported Filters:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                      Text(
                        'The following filters are required but cannot be accommodated in a standard two-filter ductless setup: ${unsupportedFilters.map((f) => 'CF-$f').join(', ')}',
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(String title, String filter) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(filter.startsWith('CF-') ? filter : 'CF-$filter'),
        ],
      ),
    );
  }
}