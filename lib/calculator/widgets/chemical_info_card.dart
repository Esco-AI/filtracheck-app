import 'package:flutter/material.dart';
import '../../models/chemical.dart'; // Adjust import path as needed

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
              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
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

  // This helper method is specific to this card, so it's fine to keep it here.
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
