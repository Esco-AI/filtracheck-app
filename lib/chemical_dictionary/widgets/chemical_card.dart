import 'package:flutter/material.dart';
import '../../../models/chemical.dart';
import 'frosted.dart';
import 'badge.dart';

class ChemicalCard extends StatelessWidget {
  final Chemical chemical;
  final VoidCallback onTap;

  const ChemicalCard({super.key, required this.chemical, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final density = (chemical.properties['SPECIFIC GRAVITY'] ?? 'N/A')
        .toString();
    final mw = (chemical.properties['MOLECULAR WEIGHT (MW)'] ?? 'N/A')
        .toString();

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Frosted(
        borderRadius: 18,
        blur: 14,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBadge(formula: chemical.formula),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chemical.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        BadgePill(
                          text: chemical.casNo.isEmpty
                              ? 'No CAS'
                              : chemical.casNo,
                        ),
                        BadgePill(
                          text: chemical.formula.isEmpty
                              ? '—'
                              : chemical.formula,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _MiniRow(label: 'Density (SG)', value: density),
                    const SizedBox(height: 6),
                    _MiniRow(label: 'Mol. Weight', value: mw),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final String formula;
  const _IconBadge({required this.formula});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D7AC8).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        formula.isNotEmpty ? _short(formula) : 'Ch',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }

  String _short(String f) => f.length <= 4 ? f : f.substring(0, 4);
}

class _MiniRow extends StatelessWidget {
  final String label;
  final String value;
  const _MiniRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(
              alpha: 0.85,
            ), // Changed back to light
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white, // Changed back to white
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
