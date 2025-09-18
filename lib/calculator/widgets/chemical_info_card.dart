import 'package:flutter/material.dart';
import '../../models/chemical.dart'; // Adjust import path as needed

class ChemicalInfoCard extends StatelessWidget {
  final ChemicalSelection selection;

  const ChemicalInfoCard({super.key, required this.selection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selection.chemical.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
              color: Colors.white.withOpacity(0.8),
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
