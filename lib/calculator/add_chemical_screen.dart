import 'package:flutter/material.dart';
import '../models/chemical.dart';
import '../services/chemical_service.dart';

class AddChemicalScreen extends StatefulWidget {
  const AddChemicalScreen({
    super.key,
  }); // No initialSelection needed here anymore

  @override
  State<AddChemicalScreen> createState() => _AddChemicalScreenState();
}

class _AddChemicalScreenState extends State<AddChemicalScreen> {
  final _formKey = GlobalKey<FormState>();
  final ChemicalService _chemicalService = ChemicalService();

  // Form state
  Chemical? _selectedChemical;
  final _volumeController = TextEditingController();
  final _frequencyController = TextEditingController();
  bool _involvesHeating = false;

  // Displayed properties
  String _density = '0.00';
  String _filterType = 'N/A';

  @override
  void initState() {
    super.initState();
    if (_chemicalService.chemicals.isEmpty) {
      _chemicalService.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _volumeController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  void _updateDisplayedProperties(Chemical? chemical) {
    if (chemical == null) {
      setState(() {
        _selectedChemical = null; // Clear selected chemical
        _density = '0.00';
        _filterType = 'N/A';
      });
      return;
    }

    setState(() {
      _selectedChemical = chemical;
      _density = chemical.properties['SPECIFIC GRAVITY']?.toString() ?? 'N/A';

      final filterNames = <String>[];
      chemical.filterRecommendation.forEach((key, value) {
        if (value > 0) filterNames.add(key);
      });
      chemical.specialFilters.forEach((filter) {
        if (filter.isNotEmpty) filterNames.add(filter);
      });
      _filterType = filterNames.join(', ');
      if (_filterType.isEmpty) {
        _filterType = 'None specified';
      }
    });
  }

  void _onDone() {
    if (_formKey.currentState!.validate()) {
      final selection = ChemicalSelection(
        chemical: _selectedChemical!,
        volume: double.parse(_volumeController.text),
        frequency: double.parse(_frequencyController.text),
        involvesHeating: _involvesHeating,
      );
      // Pass the result back to the previous screen (CalculatorIntroScreen)
      Navigator.of(context).pop(selection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool chemicalsLoaded = _chemicalService.chemicals.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemical Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Chemical Dropdown
                DropdownButtonFormField<Chemical>(
                  value: _selectedChemical,
                  onChanged: chemicalsLoaded
                      ? (Chemical? newValue) =>
                            _updateDisplayedProperties(newValue)
                      : null,
                  validator: (value) =>
                      value == null ? 'Please choose a chemical' : null,
                  isExpanded: true, // <-- THE FIX IS HERE
                  items: chemicalsLoaded
                      ? _chemicalService.chemicals
                            .map<DropdownMenuItem<Chemical>>((
                              Chemical chemical,
                            ) {
                              return DropdownMenuItem<Chemical>(
                                value: chemical,
                                child: Text(
                                  chemical.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            })
                            .toList()
                      : [], // Empty list if not loaded
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: const Color(0xFF0D7AC8),
                  style: const TextStyle(color: Colors.white),
                  hint: chemicalsLoaded
                      ? const Text(
                          'Choose chemical',
                          style: TextStyle(color: Colors.white70),
                        )
                      : const Text(
                          'Loading chemicals...',
                          style: TextStyle(color: Colors.white70),
                        ),
                ),
                const SizedBox(height: 16),

                // Volume Input
                _buildTextFormField(_volumeController, 'Volume (ml)'),
                const SizedBox(height: 16),

                // Frequency Input
                _buildTextFormField(
                  _frequencyController,
                  'Frequency (no. of handlings in month)',
                ),
                const SizedBox(height: 24),

                // Read-only properties
                _buildReadOnlyField('Density', _density),
                _buildReadOnlyField(
                  '%Capacity',
                  '0.00',
                ), // Placeholder for future calculation
                _buildReadOnlyField(
                  'Mass Evaporated/month',
                  '0.00',
                ), // Placeholder for future calculation
                _buildReadOnlyField('Type of Filter', _filterType),
                const SizedBox(height: 16),

                // Heating Radio Buttons
                _buildHeatingSelector(),
                // Removed the Temperature field as per your request
                const SizedBox(height: 32),

                // Action Buttons
                _buildActionButton(
                  label: 'Done',
                  onPressed: _onDone,
                  isPrimary: true,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Does it involve heating',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Row(
          children: [
            const Text('Yes', style: TextStyle(color: Colors.white)),
            Radio<bool>(
              value: true,
              groupValue: _involvesHeating,
              onChanged: (bool? value) {
                setState(() => _involvesHeating = value!);
              },
              activeColor: Colors.white,
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
            const Text('No', style: TextStyle(color: Colors.white)),
            Radio<bool>(
              value: false,
              groupValue: _involvesHeating,
              onChanged: (bool? value) {
                setState(() => _involvesHeating = value!);
              },
              activeColor: Colors.white,
              fillColor: WidgetStateProperty.all(Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(isPrimary ? 0.28 : 0.15),
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontSize: 16,
          ),
        ),
        child: Text(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
