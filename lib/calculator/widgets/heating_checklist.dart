import 'package:flutter/material.dart';
enum Preference { efdA, efdB, efa, efh }

class HeatingChecklist extends StatelessWidget {
  final Map<String, bool> checklistValues;
  final Function(String, bool) onChanged;
  // Add state for preference selection
  final Preference? selectedPreference;
  final ValueChanged<Preference?> onPreferenceChanged;

  const HeatingChecklist({
    super.key,
    required this.checklistValues,
    required this.onChanged,
    required this.selectedPreference,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
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
          // Add the preference section here
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            'If none apply, you can still choose a general preference:',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 12),
          _buildRadioTile(
            title: 'EFD-A (More outlets & robust design)',
            value: Preference.efdA,
          ),
          _buildRadioTile(
            title: 'EFD-B (Digital airflow control)',
            value: Preference.efdB,
          ),
          _buildRadioTile(
            title: 'EFA (Energy-efficient high-performance)',
            value: Preference.efa,
          ),
          _buildRadioTile(title: 'EFH (Low-cost)', value: Preference.efh),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({required String title, required String valueKey}) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: checklistValues[valueKey],
      onChanged: (bool? value) {
        if (value != null) {
          onChanged(valueKey, value);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.cyanAccent,
      checkColor: Colors.blue,
      contentPadding: EdgeInsets.zero,
    );
  }

  // Helper for creating radio buttons
  Widget _buildRadioTile({required String title, required Preference value}) {
    return RadioListTile<Preference>(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: value,
      groupValue: selectedPreference,
      onChanged: onPreferenceChanged,
      activeColor: Colors.cyanAccent,
      contentPadding: EdgeInsets.zero,
    );
  }
}
