import 'package:flutter/material.dart';
import '../../models/chemical.dart';
import '../../services/chemical_service.dart';
import '../widgets/calc_button.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../widgets/form_blocks.dart';

class AddChemicalScreen extends StatefulWidget {
  final ChemicalSelection? chemicalSelection;
  const AddChemicalScreen({super.key, this.chemicalSelection});

  @override
  State<AddChemicalScreen> createState() => _AddChemicalScreenState();
}

class _AddChemicalScreenState extends State<AddChemicalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _svc = ChemicalService();

  Chemical? _selected;
  final _volumeCtrl = TextEditingController();
  final _freqCtrl = TextEditingController();

  String _density = '0.00';
  String _filterType = 'N/A';
  bool get _isEditing => widget.chemicalSelection != null;

  @override
  void initState() {
    super.initState();
    _svc.initialize().then((_) {
      if (!mounted) return;
      if (_isEditing) {
        _selected = widget.chemicalSelection!.chemical;
        _volumeCtrl.text = widget.chemicalSelection!.volume.toString();
        _freqCtrl.text = widget.chemicalSelection!.frequency.toString();
        _updateDisplayedProperties(_selected);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _volumeCtrl.dispose();
    _freqCtrl.dispose();
    super.dispose();
  }

  void _updateDisplayedProperties(Chemical? c) {
    if (c == null) {
      setState(() {
        _selected = null;
        _density = '0.00';
        _filterType = 'N/A';
      });
      return;
    }

    final filters = <String>[];
    c.filterRecommendation.forEach((k, v) {
      if (v > 0) filters.add(k);
    });
    for (final f in c.specialFilters) {
      if (f.isNotEmpty) filters.add(f);
    }

    setState(() {
      _selected = c;
      _density = c.properties['SPECIFIC GRAVITY']?.toString() ?? 'N/A';
      _filterType = filters.isEmpty ? 'None specified' : filters.join(', ');
    });
  }

  void _onDone() {
    if (!_formKey.currentState!.validate() || _selected == null) return;
    Navigator.of(context).pop(
      ChemicalSelection(
        chemical: _selected!,
        volume: double.parse(_volumeCtrl.text),
        frequency: double.parse(_freqCtrl.text),
        density: _density.isNotEmpty ? _density : 'N/A',
        filterType: _filterType.isNotEmpty ? _filterType : 'N/A',
      ),
    );
  }

  String? _numValidator(String? v) {
    if (v == null || v.isEmpty) return 'Please enter a value';
    if (double.tryParse(v) == null) return 'Please enter a valid number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          _isEditing ? 'Edit Chemical' : 'Add Chemical',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionHeader('Chemical Details'),
                    const SizedBox(height: 12),
                    GlassDropdownChemical(
                      items: _svc.chemicals,
                      selected: _selected,
                      onChanged: (c) => _updateDisplayedProperties(c),
                      enabled: !_isEditing,
                      validator: (v) =>
                          v == null ? 'Please choose a chemical' : null,
                    ),
                    const SizedBox(height: 12),
                    GlassTextField(
                      controller: _volumeCtrl,
                      label: 'Volume (ml)',
                      prefixIcon: Icons.local_drink_rounded,
                      validator: _numValidator,
                    ),
                    const SizedBox(height: 12),
                    GlassTextField(
                      controller: _freqCtrl,
                      label: 'Frequency (no. of handlings in month)',
                      prefixIcon: Icons.repeat_rounded,
                      validator: _numValidator,
                    ),
                    const SizedBox(height: 20),
                    const SectionHeader('Calculated'),
                    const SizedBox(height: 12),
                    CalculatedPanel(density: _density, filterType: _filterType),
                    const SizedBox(height: 24),
                    CalcButton(label: 'Done', onPressed: _onDone),
                    const SizedBox(height: 12),
                    CalcButton(
                      label: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
