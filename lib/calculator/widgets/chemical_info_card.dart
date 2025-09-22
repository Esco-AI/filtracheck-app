import 'package:flutter/material.dart';
import '../../models/chemical.dart';

class ChemicalInfoCard extends StatelessWidget {
  final ChemicalSelection selection;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ChemicalInfoCard({
    super.key,
    required this.selection,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Expanded(
                child: Text(
                  selection.chemical.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _HeaderActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
          const SizedBox(height: 12),

          // Info Rows
          _buildInfoRow('Volume', '${selection.volume} ml'),
          _buildInfoRow('Frequency', '${selection.frequency}/month'),
          _buildInfoRow('Density', selection.density),
          _buildInfoRow('% Capacity', '0.00'),
          _buildInfoRow('Mass Evap./month', '0.00'),
          _buildInfoRow('Type of Filter', selection.filterType),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// --- ACTION BUTTONS ---
class _HeaderActions extends StatelessWidget {
  const _HeaderActions({required this.onEdit, required this.onDelete});
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  static const double _radius = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          icon: Icons.delete_outline,
          tooltip: 'Delete',
          bg: Colors.red.withValues(alpha: 0.15),
          border: Colors.redAccent,
          iconColor: Colors.redAccent,
          onTap: onDelete,
        ),
        const SizedBox(width: 8),
        _buildTextButton('Edit', onEdit),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required Color bg,
    required Color border,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: onTap,
          child: SizedBox(
            height: 34,
            width: 34,
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
        side: const BorderSide(color: Colors.white),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(_radius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
