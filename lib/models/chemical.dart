import 'package:equatable/equatable.dart';

class Chemical extends Equatable {
  final String name;
  final String casNo;
  final String formula;
  final Map<String, dynamic> properties;
  final Map<String, num> filterRecommendation;
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

  @override
  List<Object?> get props => [casNo];
}

class ChemicalSelection {
  final Chemical chemical;
  final double volume;
  final double frequency;
  final bool involvesHeating;

  ChemicalSelection({
    required this.chemical,
    required this.volume,
    required this.frequency,
    required this.involvesHeating,
  });
}