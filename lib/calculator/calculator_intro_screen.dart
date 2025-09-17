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
  final List<ChemicalSelection> _selectedChemicals = [];
  bool _involvesHeating = false;

  // State for the new checklist
  final Map<String, bool> _checklistValues = {
    'perchloric_acid': false,
    'corrosive_acids': false,
    'flammable_gases': false,
    'acid_digestion': false,
    'radioactive_materials': false,
    'tall_equipment': false,
  };

  Future<void> _navigateToAddChemical() async {
    final result = await Navigator.of(context).push<ChemicalSelection>(
      MaterialPageRoute(builder: (context) => const AddChemicalScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedChemicals.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasChemicals = _selectedChemicals.isNotEmpty;

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
                if (!hasChemicals) _buildIntroView(),
                if (hasChemicals) _buildChemicalsList(),

                // Show the heating selector only if chemicals have been added
                if (hasChemicals) ...[
                  const SizedBox(height: 24),
                  _buildHeatingSelector(),
                  // Show checklist if heating is selected
                  if (_involvesHeating) _buildHeatingChecklist(),
                ],

                const SizedBox(height: 24),
                _CalcButton(
                  label: 'Add Chemical',
                  onPressed: _navigateToAddChemical,
                ),
                const SizedBox(height: 12),
                _CalcButton(
                  label: 'Evaluate',
                  onPressed: () {
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

  Widget _buildHeatingSelector() {
    final options = ["Yes", "No"];
    final selectedIndex = _involvesHeating == true ? 0 : 1;

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
                setState(() {
                  _involvesHeating = index == 0; // Yes = true, No = false
                });
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

  Widget _buildHeatingChecklist() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ducted: Help us narrow the model',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildCheckboxTile(
            title: 'Do you handle perchloric acid (heated)?',
            valueKey: 'perchloric_acid',
          ),
          _buildCheckboxTile(
            title: 'Do you handle highly corrosive acids (trace analysis)?',
            valueKey: 'corrosive_acids',
          ),
          _buildCheckboxTile(
            title: 'Do you handle highly flammable gases/vapors?',
            valueKey: 'flammable_gases',
          ),
          _buildCheckboxTile(
            title:
                'Do you handle acid digestion / hot chemicals (but not perchloric)?',
            valueKey: 'acid_digestion',
          ),
          _buildCheckboxTile(
            title: 'Do you handle radioactive materials?',
            valueKey: 'radioactive_materials',
          ),
          _buildCheckboxTile(
            title: 'Do you need extra tall work space for large equipment?',
            valueKey: 'tall_equipment',
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({required String title, required String valueKey}) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: _checklistValues[valueKey],
      onChanged: (bool? value) {
        setState(() {
          _checklistValues[valueKey] = value!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.cyanAccent,
      checkColor: Colors.blue,
      contentPadding: EdgeInsets.zero,
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
