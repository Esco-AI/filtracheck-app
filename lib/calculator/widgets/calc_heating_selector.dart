import 'package:flutter/material.dart';
import 'heating_selector.dart' as ducted;

/// Container for heating options + custom segmented switch
class CalcHeatingSelector extends StatelessWidget {
  final bool involvesHeating;
  final Map<String, bool> checklistValues;
  final ducted.Preference? selectedPreference;

  final ValueChanged<bool> onHeatingChanged;
  final void Function(String, bool) onChecklistChanged;
  final ValueChanged<ducted.Preference?> onPreferenceChanged;

  const CalcHeatingSelector({
    super.key,
    required this.involvesHeating,
    required this.checklistValues,
    required this.selectedPreference,
    required this.onHeatingChanged,
    required this.onChecklistChanged,
    required this.onPreferenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This is the "Does it involve heating?" container
        Container(
          decoration: BoxDecoration(
            // Updated to the new color, removing border and shadow
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Does it involve heating?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GlassSegmentedSwitch(
                  value: involvesHeating,
                  onChanged: onHeatingChanged,
                  useAccent: false,
                ),
              ],
            ),
          ),
        ),
        if (involvesHeating) ...[
          const SizedBox(height: 12),
          ducted.HeatingChecklist(
            checklistValues: checklistValues,
            onChanged: onChecklistChanged,
            selectedPreference: selectedPreference,
            onPreferenceChanged: onPreferenceChanged,
          ),
        ],
      ],
    );
  }
}

class GlassSegmentedSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool useAccent;

  const GlassSegmentedSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.useAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = useAccent
        ? const LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFFEC407A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Container(
      height: 36,
      width: 160,
      decoration: BoxDecoration(
        // Updated switch background
        color: Colors.black.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 80,
              height: 36,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _SegmentLabel(
                  text: 'No',
                  selected: !value,
                  onTap: () => onChanged(false),
                ),
              ),
              Expanded(
                child: _SegmentLabel(
                  text: 'Yes',
                  selected: value,
                  onTap: () => onChanged(true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentLabel extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentLabel({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white.withValues(alpha: 0.12),
      highlightColor: Colors.transparent,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: selected ? 1.0 : 0.9),
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
