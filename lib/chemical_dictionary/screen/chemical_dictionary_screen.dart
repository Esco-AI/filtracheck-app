import 'package:flutter/material.dart';

import '../../models/chemical.dart';
import '../../services/chemical_service.dart';
import '../../widgets/bottom_navigation_bar.dart';

class ChemicalDictionaryScreen extends StatefulWidget {
  const ChemicalDictionaryScreen({super.key});

  @override
  State<ChemicalDictionaryScreen> createState() =>
      _ChemicalDictionaryScreenState();
}

class _ChemicalDictionaryScreenState extends State<ChemicalDictionaryScreen> {
  final ChemicalService _chemicalService = ChemicalService();
  List<Chemical> _chemicals = [];
  List<Chemical> _filteredChemicals = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadChemicals();
    _searchController.addListener(_filterChemicals);
  }

  Future<void> _loadChemicals() async {
    await _chemicalService.initialize();
    setState(() {
      _chemicals = _chemicalService.chemicals;
      _filteredChemicals = _chemicals;
    });
  }

  void _filterChemicals() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChemicals = _chemicals.where((chemical) {
        return chemical.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chemical Dictionary',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Chemical',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChemicals.length,
              itemBuilder: (context, index) {
                final chemical = _filteredChemicals[index];
                return ChemicalDictionaryCard(chemical: chemical);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class ChemicalDictionaryCard extends StatelessWidget {
  final Chemical chemical;

  const ChemicalDictionaryCard({super.key, required this.chemical});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF3AADEA),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('CAS Number:', chemical.casNo),
            _buildInfoRow('Chemical Name:', chemical.name),
            _buildInfoRow('Formula:', chemical.formula),
            _buildInfoRow(
              'Density:',
              chemical.properties['SPECIFIC GRAVITY']?.toString() ?? 'N/A',
            ),
            _buildInfoRow(
              'Molecular Weight:',
              chemical.properties['MOLECULAR WEIGHT (MW)']?.toString() ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
