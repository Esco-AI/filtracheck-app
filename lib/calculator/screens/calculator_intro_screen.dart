import 'package:filtracheck_v2/calculator/screens/recommendation_screen.dart';
import 'package:flutter/material.dart';
import '../../models/chemical.dart';
import '../../services/recommendation_service.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../chemical_dictionary/widgets/frosted.dart';
import 'add_chemical_screen.dart';
import '../widgets/calc_button.dart';
import '../widgets/chemical_info_card.dart';
import '../widgets/calc_section_header.dart';
import '../widgets/calc_intro_view.dart';
import '../widgets/calc_heating_selector.dart';
import '../widgets/heating_selector.dart' as ducted;

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

  ducted.Preference? _selectedPreference;

  Future<void> _navigateToAddChemical({
    ChemicalSelection? chemicalToEdit,
  }) async {
    final result = await Navigator.of(context).push<ChemicalSelection>(
      MaterialPageRoute(
        builder: (context) =>
            AddChemicalScreen(chemicalSelection: chemicalToEdit),
      ),
    );
    if (result == null) return;

    setState(() {
      if (chemicalToEdit != null) {
        final index = _selectedChemicals.indexOf(chemicalToEdit);
        if (index != -1) _selectedChemicals[index] = result;
      } else {
        _selectedChemicals.add(result);
      }
    });
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
      _selectedPreference,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            RecommendationScreen(recommendation: recommendation),
      ),
    );
  }

  void _deleteChemical(int index) =>
      setState(() => _selectedChemicals.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final hasChemicals = _selectedChemicals.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: const Text(
          'Chemical Calculator',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Frosted(
            borderRadius: 24,
            blur: 16,
            gradient: const LinearGradient(
              colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!hasChemicals) const CalcIntroView(),
                  if (hasChemicals) ...[
                    const CalcSectionHeader(title: 'Selected Chemicals'),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _selectedChemicals.length,
                      itemBuilder: (_, i) => ChemicalInfoCard(
                        selection: _selectedChemicals[i],
                        onEdit: () => _navigateToAddChemical(
                          chemicalToEdit: _selectedChemicals[i],
                        ),
                        onDelete: () => _deleteChemical(i),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                    ),
                    const SizedBox(height: 20),
                    const CalcSectionHeader(title: 'Preferences'),
                    const SizedBox(height: 12),
                    CalcHeatingSelector(
                      involvesHeating: _involvesHeating,
                      checklistValues: _checklistValues,
                      selectedPreference: _selectedPreference,
                      onHeatingChanged: (v) =>
                          setState(() => _involvesHeating = v),
                      onChecklistChanged: (k, v) => setState(() {
                        _checklistValues[k] = v;
                        if (_checklistValues.values.any((v) => v)) {
                          _selectedPreference = null;
                        }
                      }),
                      onPreferenceChanged: (val) => setState(() {
                        _selectedPreference = _selectedPreference == val
                            ? null
                            : val;
                      }),
                    ),
                  ],
                  const SizedBox(height: 24),
                  CalcButton(
                    label: 'Add Chemical',
                    onPressed: () => _navigateToAddChemical(),
                  ),
                  const SizedBox(height: 12),
                  CalcButton(label: 'Evaluate', onPressed: _evaluateChemicals),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
