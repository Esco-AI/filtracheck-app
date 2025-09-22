import 'package:flutter/material.dart';
import 'heating_selector.dart' as ducted;

/// Frosted container + custom glass segmented switch
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
        Container(
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
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
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
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            alignment: value ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 80,
              height: 36,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: _SegmentLabel(
                  text: 'Yes',
                  selected: value,
                  onTap: () => onChanged(true),
                ),
              ),
              Expanded(
                child: _SegmentLabel(
                  text: 'No',
                  selected: !value,
                  onTap: () => onChanged(false),
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
