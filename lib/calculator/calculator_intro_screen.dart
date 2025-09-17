import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/chemical.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'add_chemical_screen.dart';

class CalculatorIntroScreen extends StatefulWidget {
  const CalculatorIntroScreen({super.key});

  @override
  State<CalculatorIntroScreen> createState() => _CalculatorIntroScreenState();
}

class _CalculatorIntroScreenState extends State<CalculatorIntroScreen> {
  // List to store the chemical selections
  final List<ChemicalSelection> _selectedChemicals = [];

  // Navigate to AddChemicalScreen and wait for a result
  Future<void> _navigateToAddChemical() async {
    final result = await Navigator.of(context).push<ChemicalSelection>(
      MaterialPageRoute(builder: (context) => const AddChemicalScreen()),
    );

    // If a chemical was selected and 'Done' was pressed, add it to the list
    if (result != null) {
      setState(() {
        _selectedChemicals.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chemical Calculator',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Conditionally show intro or the list of chemicals
                if (_selectedChemicals.isEmpty)
                  _buildIntroView()
                else
                  _buildChemicalsList(),

                const SizedBox(height: 24),

                _CalcButton(
                  label: 'Add Chemical',
                  onPressed: _navigateToAddChemical,
                ),
                const SizedBox(height: 12),
                _CalcButton(
                  label: 'Evaluate',
                  onPressed: () {
                    // TODO: navigate to Evaluate page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Evaluate tapped')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  // The intro view when no chemicals are added
  Widget _buildIntroView() {
    return Column(
      children: [
        Text(
          'Kindly list down all chemicals that you intend to use inside the fume hood.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 180,
          width: 220,
          child: SvgPicture.asset(
            'assets/images/calculator-chemical-icon.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  // The view to display the list of added chemicals
  Widget _buildChemicalsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _selectedChemicals.length,
      itemBuilder: (context, index) {
        final selection = _selectedChemicals[index];
        return _ChemicalInfoCard(selection: selection);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}

// A button styled for this screen
class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _CalcButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 240,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.28),
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

// A card widget to display the selected chemical's info
class _ChemicalInfoCard extends StatelessWidget {
  final ChemicalSelection selection;

  const _ChemicalInfoCard({required this.selection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selection.chemical.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Volume:', '${selection.volume} ml'),
          _buildInfoRow('Frequency:', '${selection.frequency}/month'),
          _buildInfoRow('Heating:', selection.involvesHeating ? 'Yes' : 'No'),
          _buildInfoRow('Density:', selection.density),
          _buildInfoRow('%Capacity:', '0.00'),
          _buildInfoRow('Mass Evaporated/month:', '0.00'),
          _buildInfoRow('Type of Filter:', selection.filterType),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
      ), // Added slight padding for spacing
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
