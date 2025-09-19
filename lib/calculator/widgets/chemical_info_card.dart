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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selection.chemical.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _HeaderActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),

          const SizedBox(height: 8),
          _buildInfoRow('Volume:', '${selection.volume} ml'),
          _buildInfoRow('Frequency:', '${selection.frequency}/month'),
          _buildInfoRow('Density:', selection.density),
          _buildInfoRow('%Capacity:', '0.00'),
          _buildInfoRow('Mass Evaporated/month:', '0.00'),
          _buildInfoRow('Type of Filter:', selection.filterType),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  static const double _height = 34;
  static const double _radius = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Delete',
          child: Material(
            color: Colors.red.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
              side: const BorderSide(color: Colors.red),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(_radius),
              onTap: onDelete,
              child: SizedBox(
                height: _height,
                width: _height,
                child: const Center(
                  child: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
            side: const BorderSide(color: Colors.white),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(_radius),
            onTap: onEdit,
            child: const _EditLabel(),
          ),
        ),
      ],
    );
  }
}

class _EditLabel extends StatelessWidget {
  const _EditLabel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: const Text(
        'Edit',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
