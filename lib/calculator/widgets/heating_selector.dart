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
    final bool noSpecificOptionSelected = checklistValues.values.every(
      (isSelected) => !isSelected,
    );

    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + accent
            Row(
              children: [
                const Text(
                  'Ducted: Help us narrow the model',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),

            // Checkboxes
            _checkboxTile(
              title: 'Do you handle perchloric acid (heated)?',
              valueKey: 'perchloric_acid',
            ),
            _checkboxTile(
              title: 'Do you handle highly corrosive acids (trace analysis)?',
              valueKey: 'corrosive_acids',
            ),
            _checkboxTile(
              title: 'Do you handle highly flammable gases/vapors?',
              valueKey: 'flammable_gases',
            ),
            _checkboxTile(
              title:
                  'Do you handle acid digestion / hot chemicals (but not perchloric)?',
              valueKey: 'acid_digestion',
            ),
            _checkboxTile(
              title: 'Do you handle radioactive materials?',
              valueKey: 'radioactive_materials',
            ),
            _checkboxTile(
              title: 'Do you need extra tall work space for large equipment?',
              valueKey: 'tall_equipment',
            ),

            if (noSpecificOptionSelected) ...[
              const SizedBox(height: 16),
              Divider(color: Colors.white.withValues(alpha: 0.15)),
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
                    _radioTile(
                      context: context,
                      title: 'EFD-A (More outlets & robust design)',
                      value: Preference.efdA,
                    ),
                    _radioTile(
                      context: context,
                      title: 'EFD-B (Digital airflow control)',
                      value: Preference.efdB,
                    ),
                    _radioTile(
                      context: context,
                      title: 'EFA (Energy-efficient high-performance)',
                      value: Preference.efa,
                    ),
                    _radioTile(
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
      ),
    );
  }

  Widget _checkboxTile({required String title, required String valueKey}) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
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
    );
  }

  Widget _radioTile({
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
          if (states.contains(WidgetState.selected)) return Colors.cyanAccent;
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
