import 'package:flutter/material.dart';

enum Preference { efdA, efdB, efa, efh }

class HeatingChecklist extends StatelessWidget {
  final Map<String, bool> checklistValues;
  final Function(String, bool) onChanged;
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
    // Determine if any of the specific checkboxes are selected.
    final bool noSpecificOptionSelected = checklistValues.values.every(
      (isSelected) => !isSelected,
    );

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
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

          // Conditionally display the preference section
          if (noSpecificOptionSelected) ...[
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            const Text(
              'If none apply, you can still choose a general preference:',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 12),
            RadioGroup<Preference>(
              groupValue: selectedPreference,
              onChanged: onPreferenceChanged,
              child: Column(
                children: [
                  _buildRadioTile(
                    context: context,
                    title: 'EFD-A (More outlets & robust design)',
                    value: Preference.efdA,
                  ),
                  _buildRadioTile(
                    context: context,
                    title: 'EFD-B (Digital airflow control)',
                    value: Preference.efdB,
                  ),
                  _buildRadioTile(
                    context: context,
                    title: 'EFA (Energy-efficient high-performance)',
                    value: Preference.efa,
                  ),
                  _buildRadioTile(
                    context: context,
                    title: 'EFH (Low-cost)',
                    value: Preference.efh,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({required String title, required String valueKey}) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      value: checklistValues[valueKey],
      onChanged: (bool? value) {
        if (value != null) onChanged(valueKey, value);
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.cyanAccent,
      checkColor: Colors.black,
      side: const BorderSide(color: Colors.white),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildRadioTile({
    required BuildContext context,
    required String title,
    required Preference value,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<Preference>(
        value: value,
        activeColor: Colors.cyanAccent,
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.cyanAccent;
          }
          return Colors.white;
        }),
        toggleable: true,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      onTap: () => onPreferenceChanged(value),
    );
  }
}
