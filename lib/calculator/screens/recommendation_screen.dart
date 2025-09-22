import 'package:flutter/material.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../chemical_dictionary/widgets/gradient_background.dart';
import '../../chemical_dictionary/widgets/frosted.dart';

class RecommendationScreen extends StatelessWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationScreen({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final bool isDucted = recommendation['isDucted'] ?? false;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Recommendation Result',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0, -1.2),
              end: const Alignment(0, 1),
              colors: [
                Colors.black.withValues(alpha: 0.25),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const GradientBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Frosted(
                borderRadius: 24,
                blur: 16,
                tint: Colors.white.withValues(alpha: 0.06),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                  child: isDucted
                      ? _buildDuctedRecommendation(context)
                      : _buildDuctlessRecommendation(context),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  // ----- Ductless -----
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
        const _SectionHeader(title: 'Ductless Fume Hood'),
        const SizedBox(height: 16),
        _infoRow('No. of Fume Hood Unit:', '1'),
        _infoRow('No. of Filter:', filterCount.toString()),
        _infoRow(
          'Main Filter:',
          mainFilter != null ? 'Type $mainFilter' : 'None',
        ),
        _infoRow(
          'Secondary Filter:',
          secondaryFilter != null ? 'Type $secondaryFilter' : 'None',
        ),
        _infoRow('Fume Hood Model:', 'ADC-B or D/SPD/SPB'),
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

  // ----- Ducted -----
  Widget _buildDuctedRecommendation(BuildContext context) {
    final List<String> reasons = recommendation['reasons'] ?? [];
    final List<String> ductedModels = recommendation['ductedModels'] ?? [];
    final bool multipleDuctedOptions =
        recommendation['multipleDuctedOptions'] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(title: 'Ducted Fume Hood'),
        const SizedBox(height: 16),
        _infoRow('No. of Fume Hood Unit:', '1'),
        _infoRow('No. of Filter:', 'N/A'),
        _infoRow('Main Filter:', 'None'),
        _infoRow('Secondary Filter:', 'None'),
        _infoRow(
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

  // ----- Shared bits -----
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
              ),
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

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

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
        Container(
          height: 4,
          width: 40,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7E57C2), Color(0xFFEC407A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ],
    );
  }
}
