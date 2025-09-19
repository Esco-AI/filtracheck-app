import 'package:flutter/material.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../widgets/gradient_form_container.dart';

class RecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationScreen({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final bool isDucted = recommendation['isDucted'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommendation Result',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: GradientFormContainer(
          child: isDucted
              ? _buildDuctedRecommendation(context)
              : _buildDuctlessRecommendation(context),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  Widget _buildDuctlessRecommendation(BuildContext context) {
    final String? mainFilter = recommendation['mainFilter'];
    final String? secondaryFilter = recommendation['secondaryFilter'];
    final List<String> unsupportedFilters =
        recommendation['unsupportedFilters'] ?? [];

    int filterCount = 0;
    if (mainFilter != null) filterCount++;
    if (secondaryFilter != null) filterCount++;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildResultHeader('Ductless Fume Hood'),
        const SizedBox(height: 16),
        _buildInfoRow('No. of Fume Hood Unit:', '1'),
        _buildInfoRow('No. of Filter:', filterCount.toString()),
        _buildInfoRow(
          'Main Filter:',
          mainFilter != null ? 'Type $mainFilter' : 'None',
        ),
        _buildInfoRow(
          'Secondary Filter:',
          secondaryFilter != null ? 'Type $secondaryFilter' : 'None',
        ),
        _buildInfoRow('Fume Hood Model:', 'ADC-B or D/SPD/SPB'), // As per image
        if (unsupportedFilters.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            'Unsupported Filters:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red[300],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The following filters are also required but cannot be accommodated: ${unsupportedFilters.join(', ')}.\nA ducted hood might be a better solution.',
            style: TextStyle(color: Colors.red[300]),
          ),
        ],
      ],
    );
  }

  Widget _buildDuctedRecommendation(BuildContext context) {
    final List<String> reasons = recommendation['reasons'] ?? [];
    final List<String> ductedModels = recommendation['ductedModels'] ?? [];
    final bool multipleDuctedOptions =
        recommendation['multipleDuctedOptions'] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildResultHeader('Ducted Fume Hood'),
        const SizedBox(height: 16),
        _buildInfoRow('No. of Fume Hood Unit:', '1'),
        _buildInfoRow('No. of Filter:', 'N/A'),
        _buildInfoRow('Main Filter:', 'None'),
        _buildInfoRow('Secondary Filter:', 'None'),
        _buildInfoRow(
          'Fume Hood Model:',
          ductedModels.isNotEmpty
              ? ductedModels.join(' or ')
              : 'To be determined',
        ),
        if (reasons.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            'Reason(s) for Ducted Recommendation:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...reasons.map(
            (reason) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                '• $reason',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
        if (multipleDuctedOptions) ...[
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            "We couldn't decide on a specific model. Please refine your preferences on the previous screen.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orange[200], fontSize: 14),
          ),
        ],
        if (ductedModels.isEmpty && !multipleDuctedOptions) ...[
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            'Please select your general preferences on the previous screen to narrow down the model recommendation.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.cyanAccent[100], fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildResultHeader(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
