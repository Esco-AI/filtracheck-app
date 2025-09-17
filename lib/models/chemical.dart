// lib/models/chemical.dart

import 'package:equatable/equatable.dart';

class Chemical extends Equatable {
  final String name;
  final String casNo;
  final String formula;
  final Map<String, dynamic> properties;
  final Map<String, double> filterRecommendation;
  final List<String> specialFilters;
  final String? combinationNote;
  final String? nonDuctlessProduct;

  const Chemical({
    required this.name,
    required this.casNo,
    required this.formula,
    required this.properties,
    required this.filterRecommendation,
    required this.specialFilters,
    this.combinationNote,
    this.nonDuctlessProduct,
  });

  // This factory constructor correctly handles potential null values from the CSV map.
  factory Chemical.fromMap(Map<String, dynamic> map) {
    final filterQuantities = <String, double>{};
    final specialFilters = <String>[];

    // Parse A-H filters
    const filterCols = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    for (var col in filterCols) {
      if (map[col] != null && map[col].toString().trim().isNotEmpty) {
        final value = double.tryParse(map[col].toString().replaceAll(',', '.'));
        if (value != null && value > 0) {
          filterQuantities[col] = value;
        }
      }
    }

    // Parse special filters
    const specialCols = ['HEPA', 'ESCO', '!'];
    for (var col in specialCols) {
      if (map[col] != null && map[col].toString().trim().isNotEmpty) {
        final value = double.tryParse(map[col].toString());
        if (value != null && value == 1.0) {
          specialFilters.add(col);
        }
      }
    }

    return Chemical(
      // THE FIX: Use '??' to provide a default empty string if the value is null.
      name: map['CHEMICAL NAME']?.toString() ?? '',
      casNo: map['CAS No.']?.toString() ?? '',
      formula: map['FORMULA']?.toString() ?? '',
      properties: map,
      filterRecommendation: filterQuantities,
      specialFilters: specialFilters,
      combinationNote: map['COMBINATION']?.toString(),
      nonDuctlessProduct: map['NON DUCTLESS RECOMMENDED PRODUCTS']?.toString(),
    );
  }

  @override
  List<Object?> get props => [casNo];
}

class ChemicalSelection {
  final Chemical chemical;
  final double volume;
  final double frequency;
  final bool involvesHeating;
  final String density;
  final String filterType;

  ChemicalSelection({
    required this.chemical,
    required this.volume,
    required this.frequency,
    required this.involvesHeating,
    required this.density,
    required this.filterType,
  });
}
