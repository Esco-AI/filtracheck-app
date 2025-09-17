import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/chemical.dart';

class ChemicalService {
  List<Chemical> _chemicals = [];
  bool _isInitialized = false;

  // Singleton pattern to ensure we only load the data once.
  static final ChemicalService _instance = ChemicalService._internal();
  factory ChemicalService() {
    return _instance;
  }
  ChemicalService._internal();

  // Public getter for the chemical list.
  List<Chemical> get chemicals => _chemicals;

  // Load and parse the CSV from assets.
  Future<void> initialize() async {
    if (_isInitialized) return;

    final rawData = await rootBundle.loadString(
      'assets/data/chemical_guide_for_filtracheck.csv',
    );
    final List<List<dynamic>> listData = const CsvToListConverter(
      shouldParseNumbers: false,
    ).convert(rawData);

    if (listData.isEmpty) {
      _isInitialized = true;
      return;
    }

    final headers = listData[0].map((h) => (h as String).trim()).toList();
    final nameIndex = headers.indexOf('CHEMICAL NAME');
    final casIndex = headers.indexOf('CAS No.');
    final formulaIndex = headers.indexOf('FORMULA');

    final filterCols = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    final specialFilterCols = ['HEPA', 'ESCO', '!'];
    final combinationIndex = headers.indexOf('COMBINATION');
    final nonDuctlessIndex = headers.indexOf(
      'NON DUCTLESS RECOMMENDED PRODUCTS',
    );

    _chemicals = listData.sublist(1).map((row) {
      final properties = <String, dynamic>{};
      for (var i = 0; i < headers.length; i++) {
        if (i < row.length) {
          properties[headers[i]] = row[i];
        } else {
          properties[headers[i]] = '';
        }
      }

      final recommendation = <String, num>{};
      for (final col in filterCols) {
        final index = headers.indexOf(col);
        if (index != -1) {
          final val = num.tryParse(row[index].toString());
          if (val != null && val > 0) {
            recommendation[col] = val;
          }
        }
      }

      final special = <String>[];
      for (final col in specialFilterCols) {
        final index = headers.indexOf(col);
        if (index != -1) {
          final val = num.tryParse(row[index].toString());
          if (val == 1) {
            special.add(col);
          }
        }
      }

      return Chemical(
        name: row[nameIndex].toString().trim(),
        casNo: row[casIndex].toString().trim(),
        formula: row[formulaIndex].toString().trim(),
        properties: properties,
        filterRecommendation: recommendation,
        specialFilters: special,
        combinationNote: combinationIndex != -1
            ? row[combinationIndex].toString().trim()
            : null,
        nonDuctlessProduct: nonDuctlessIndex != -1
            ? row[nonDuctlessIndex].toString().trim()
            : null,
      );
    }).toList();

    _isInitialized = true;
  }
}
