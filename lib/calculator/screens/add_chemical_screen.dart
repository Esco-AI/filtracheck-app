import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../models/chemical.dart';
import '../../services/chemical_service.dart';
import '../widgets/gradient_form_container.dart';
import '../widgets/read_only_info_row.dart';
import '../widgets/form_action_button.dart';
import '../../widgets/bottom_navigation_bar.dart';

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
    _chemicalService.initialize().then((_) {
      if (mounted) setState(() {});
    });
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
      for (var filter in chemical.specialFilters) {
        if (filter.isNotEmpty) filterNames.add(filter);
      }
      _filterType = filterNames.join(', ');
      if (_filterType.isEmpty) _filterType = 'None specified';
    });
  }

  void _onDone() {
    if (_formKey.currentState!.validate()) {
      if (_selectedChemical == null) return;
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
                DropdownSearch<Chemical>(
                  // Use 'items' for a local list
                  items: _chemicalService.chemicals,
                  itemAsString: (Chemical? u) => u?.name ?? '',
                  onChanged: (Chemical? data) =>
                      _updateDisplayedProperties(data),
                  selectedItem: _selectedChemical,
                  validator: (value) =>
                      value == null ? 'Please choose a chemical' : null,

                  // Props for the popup menu
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        "Search Chemical",
                        isHint: true,
                      ),
                    ),
                    itemBuilder: (context, chemical, isSelected) {
                      return ListTile(
                        title: Text(
                          chemical.name,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.cyanAccent
                                : Colors.white,
                          ),
                        ),
                      );
                    },

                    // Set the background color for the popup list
                    menuProps: MenuProps(
                      backgroundColor: const Color(
                        0xFF0D7AC8,
                      ).withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    dropdownSearchDecoration: _inputDecoration(
                      'Choose chemical',
                    ),
                  ),
                  dropdownButtonProps: DropdownButtonProps(color: Colors.white),
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
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
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
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, {bool isHint = false}) {
    return InputDecoration(
      labelText: isHint ? null : label,
      hintText: isHint ? label : null,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 1.0),
      ),
    );
  }
}
