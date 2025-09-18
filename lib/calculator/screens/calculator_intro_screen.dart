import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/chemical.dart';
import '../../services/recommendation_service.dart';
import '../../widgets/bottom_navigation_bar.dart';
import 'add_chemical_screen.dart';
import '../widgets/calc_button.dart';
import '../widgets/chemical_info_card.dart';
import '../widgets/heating_checklist.dart';
import '../widgets/heating_selector.dart';
import 'recommendation_screen.dart';

class CalculatorIntroScreen extends StatefulWidget {
  const CalculatorIntroScreen({super.key});

  @override
  State<CalculatorIntroScreen> createState() => _CalculatorIntroScreenState();
}

class _CalculatorIntroScreenState extends State<CalculatorIntroScreen> {
  final List<ChemicalSelection> _selectedChemicals = [];
  bool _involvesHeating = false;
  final Map<String, bool> _checklistValues = {
    'perchloric_acid': false,
    'corrosive_acids': false,
    'flammable_gases': false,
    'acid_digestion': false,
    'radioactive_materials': false,
    'tall_equipment': false,
  };

  Preference? _selectedPreference;

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

  void _evaluateChemicals() {
    if (_selectedChemicals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one chemical.')),
      );
      return;
    }

    final recommendation = RecommendationService.evaluate(
      _selectedChemicals,
      _involvesHeating,
      _checklistValues,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            RecommendationScreen(recommendation: recommendation),
      ),
    );
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
                if (hasChemicals) ...[
                  const SizedBox(height: 24),
                  HeatingSelector(
                    involvesHeating: _involvesHeating,
                    onChanged: (value) {
                      setState(() {
                        _involvesHeating = value;
                      });
                    },
                  ),
                  if (_involvesHeating)
                    HeatingChecklist(
                      checklistValues: _checklistValues,
                      onChanged: (key, value) {
                        setState(() {
                          _checklistValues[key] = value;
                        });
                      },
                      selectedPreference: _selectedPreference,
                      onPreferenceChanged: (value) {
                        setState(() {
                          if (_selectedPreference == value) {
                            _selectedPreference = null;
                          } else {
                            _selectedPreference = value;
                          }
                        });
                      },
                    ),
                ],
                const SizedBox(height: 24),
                CalcButton(
                  label: 'Add Chemical',
                  onPressed: _navigateToAddChemical,
                ),
                const SizedBox(height: 12),
                CalcButton(label: 'Evaluate', onPressed: _evaluateChemicals),
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
        const Text(
          'Kindly list down all chemicals that you intend to use inside the fume hood.',
          textAlign: TextAlign.center,
          style: TextStyle(
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
        return ChemicalInfoCard(selection: selection);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
