import 'package:flutter/material.dart';

class HeatingChecklist extends StatelessWidget {
  final Map<String, bool> checklistValues;
  final Function(String, bool) onChanged;

  const HeatingChecklist({
    super.key,
    required this.checklistValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
}
