import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/chemical.dart';

class ChemicalService {
  List<Chemical> _chemicals = [];
  bool _isInitialized = false;

  static final ChemicalService _instance = ChemicalService._internal();
  factory ChemicalService() => _instance;
  ChemicalService._internal();

  List<Chemical> get chemicals => _chemicals;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final rawData = await rootBundle.loadString(
      'assets/data/chemical_guide_for_filtracheck.csv',
    );

    // Use the robust CSV package, allowing for fields that contain commas
    final List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(
      eol: '\n',
      shouldParseNumbers: false,
    ).convert(rawData);

    if (rowsAsListOfValues.length < 2) {
      _isInitialized = true;
      return;
    }

    final headers = rowsAsListOfValues[0]
        .map((h) => h.toString().trim())
        .toList();
    final List<Chemical> parsedChemicals = [];

    // Start from the first data row (index 1)
    for (var i = 1; i < rowsAsListOfValues.length; i++) {
      final rowValues = rowsAsListOfValues[i];

      // Create a map from headers to row values, which is the key step from v1
      final rowMap = <String, dynamic>{};
      for (int j = 0; j < headers.length; j++) {
        if (j < rowValues.length) {
          rowMap[headers[j]] = rowValues[j];
        }
      }

      try {
        // Use the safe factory constructor from the Chemical model
        final chemical = Chemical.fromMap(rowMap);
        if (chemical.name.isNotEmpty && chemical.casNo.isNotEmpty) {
          parsedChemicals.add(chemical);
        }
      } catch (e) {
        // This will help debug any single bad row in the CSV without crashing
        if (kDebugMode) {
          print('Error parsing row $i: $e');
        }
      }
    }

    _chemicals = parsedChemicals;
    _isInitialized = true;
  }
}
