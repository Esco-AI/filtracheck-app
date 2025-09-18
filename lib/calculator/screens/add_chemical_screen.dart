import 'package:flutter/material.dart';
import '../../models/chemical.dart';
import '../../services/chemical_service.dart';
import '../widgets/gradient_form_container.dart';
import '../widgets/read_only_info_row.dart';
import '../widgets/form_action_button.dart';

class AddChemicalScreen extends StatefulWidget {
  const AddChemicalScreen({super.key});

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

  // Displayed properties
  String _density = '0.00';
  String _filterType = 'N/A';

  @override
  void initState() {
    super.initState();
    if (_chemicalService.chemicals.isEmpty) {
      _chemicalService.initialize().then((_) {
        if (mounted) setState(() {});
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
        _selectedChemical = null;
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
      if (_filterType.isEmpty) _filterType = 'None specified';
    });
  }

  void _onDone() {
    if (_formKey.currentState!.validate()) {
      final selection = ChemicalSelection(
        chemical: _selectedChemical!,
        volume: double.parse(_volumeController.text),
        frequency: double.parse(_frequencyController.text),
        density: _density.isNotEmpty ? _density : 'N/A',
        filterType: _filterType.isNotEmpty ? _filterType : 'N/A',
      );
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
          child: GradientFormContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<Chemical>(
                  value: _selectedChemical,
                  onChanged: chemicalsLoaded
                      ? (Chemical? newValue) =>
                            _updateDisplayedProperties(newValue)
                      : null,
                  validator: (value) =>
                      value == null ? 'Please choose a chemical' : null,
                  isExpanded: true,
                  items: _chemicalService.chemicals
                      .map<DropdownMenuItem<Chemical>>(
                        (c) => DropdownMenuItem<Chemical>(
                          value: c,
                          child: Text(c.name, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  decoration: _inputDecoration(
                    chemicalsLoaded
                        ? 'Choose chemical'
                        : 'Loading chemicals...',
                    isHint: true,
                  ),
                  dropdownColor: const Color(0xFF0D7AC8),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                _buildTextFormField(_volumeController, 'Volume (ml)'),
                const SizedBox(height: 16),
                _buildTextFormField(
                  _frequencyController,
                  'Frequency (no. of handlings in month)',
                ),
                const SizedBox(height: 24),
                ReadOnlyInfoRow(label: 'Density', value: _density),
                const ReadOnlyInfoRow(label: '%Capacity', value: '0.00'),
                const ReadOnlyInfoRow(
                  label: 'Mass Evaporated/month',
                  value: '0.00',
                ),
                ReadOnlyInfoRow(label: 'Type of Filter', value: _filterType),
                const SizedBox(height: 32),
                FormActionButton(
                  label: 'Done',
                  onPressed: _onDone,
                  isPrimary: true,
                ),
                const SizedBox(height: 12),
                FormActionButton(
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
        if (value == null || value.isEmpty) return 'Please enter a value';
        if (double.tryParse(value) == null)
          return 'Please enter a valid number';
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, {bool isHint = false}) {
    return InputDecoration(
      labelText: isHint ? null : label,
      hintText: isHint ? label : null,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
