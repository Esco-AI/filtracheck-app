import 'package:filtracheck_v2/calculator/widgets/heating_selector.dart';
import 'package:filtracheck_v2/models/chemical.dart';
import 'package:filtracheck_v2/models/product.dart';

class RecommendationService {
  static Map<String, dynamic> evaluate(
    List<ChemicalSelection> selections,
    bool involvesHeating,
    Map<String, bool> checklistValues,
    Preference? preference,
  ) {
    // --- Step 1 & 2: Analysis and Ducted/Ductless Decision ---
    final Set<String> distinctFilters = {};
    final Map<String, double> weightedSumQF = {};
    final Map<String, int> filterOccurrenceCounts = {};
    final Set<String> specialFilters = {};

    for (final selection in selections) {
      final chemical = selection.chemical;
      final qf = selection.volume * selection.frequency;

      for (var filterKey in chemical.filterRecommendation.keys) {
        distinctFilters.add(filterKey);
        weightedSumQF.update(
          filterKey,
          (value) => value + qf,
          ifAbsent: () => qf,
        );
        filterOccurrenceCounts.update(
          filterKey,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
      for (var special in chemical.specialFilters) {
        specialFilters.add(special);
      }
    }

    bool defaultIsDucted = false;
    final List<String> reasons = [];
    if (involvesHeating) {
      defaultIsDucted = true;
      reasons.add("Heating is involved.");
    }
    if (distinctFilters.length > 2) {
      defaultIsDucted = true;
      reasons.add(
        "More than 2 distinct filters are required (${distinctFilters.length}).",
      );
    }

    // --- Step 3: Ductless Logic ---
    String? mainFilter;
    String? secondaryFilter;
    List<String> unsupportedFilters = [];
    Product? ductlessProduct;

    if (!defaultIsDucted) {
      if (distinctFilters.isNotEmpty) {
        final ranking = distinctFilters.map((key) {
          final n = filterOccurrenceCounts[key] ?? 0;
          final s = weightedSumQF[key] ?? 0.0;
          final score = s * n;
          return Tuple(key, score, n, s);
        }).toList();

        ranking.sort((a, b) {
          int scoreComp = b.item2.compareTo(a.item2);
          if (scoreComp != 0) return scoreComp;
          int nComp = b.item3.compareTo(a.item3);
          if (nComp != 0) return nComp;
          int sComp = b.item4.compareTo(a.item4);
          if (sComp != 0) return sComp;
          return a.item1.compareTo(b.item1);
        });

        if (ranking.isNotEmpty) mainFilter = ranking[0].item1;
        if (ranking.length > 1) secondaryFilter = ranking[1].item1;
        if (ranking.length > 2) {
          unsupportedFilters = ranking.sublist(2).map((t) => t.item1).toList();
        }
      }

      // --- Ductless Model Selection Logic ---
      String ductlessModelKey = 'ADC-B'; // Default key
      final bool needsHep = specialFilters.contains('HEPA');
      final bool usesFormalin = selections.any(
        (s) => s.chemical.name.toLowerCase().contains('formalin'),
      );

      if (needsHep) {
        ductlessModelKey = (mainFilter != null) ? 'ADC-D' : 'PW1';
      } else if (usesFormalin) {
        ductlessModelKey = 'SPF';
      } else {
        if (mainFilter != null && secondaryFilter != null) {
          ductlessModelKey = 'ADC-C';
        } else if (mainFilter != null) {
          ductlessModelKey = 'ADC-B';
        }
      }
      ductlessProduct = productDatabase[ductlessModelKey];
    }

    // --- Step 4: Ducted Hood Specific Logic ---
    List<Product> ductedProducts = [];
    if (defaultIsDucted) {
      final Map<String, bool> selections = {
        "EFP": checklistValues['perchloric_acid'] ?? false,
        "EFA-XP": checklistValues['flammable_gases'] ?? false,
        "EFI": checklistValues['radioactive_materials'] ?? false,
        "PPH": checklistValues['corrosive_acids'] ?? false,
        "EFQ/EFA-M": checklistValues['acid_digestion'] ?? false,
        "EFF": checklistValues['tall_equipment'] ?? false,
      };

      final picked = selections.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      if (picked.length == 1) {
        if (picked[0] == "EFQ/EFA-M") {
          if (productDatabase['EFQ'] != null) {
            ductedProducts.add(productDatabase['EFQ']!);
          }
          if (productDatabase['EFA-M'] != null) {
            ductedProducts.add(productDatabase['EFA-M']!);
          }
        } else {
          if (productDatabase[picked[0]] != null) {
            ductedProducts.add(productDatabase[picked[0]]!);
          }
        }
      } else if (picked.length > 1) {
        if (preference != null) {
          const prefMap = {
            Preference.efdA: 'EFD-A',
            Preference.efdB: 'EFD-B',
            Preference.efa: 'EFA',
            Preference.efh: 'EFH',
          };
          final modelKey = prefMap[preference];
          if (modelKey != null && productDatabase[modelKey] != null) {
            ductedProducts.add(productDatabase[modelKey]!);
          }
        }
      } else {
        if (preference != null) {
          const prefMap = {
            Preference.efdA: 'EFD-A',
            Preference.efdB: 'EFD-B',
            Preference.efa: 'EFA',
            Preference.efh: 'EFH',
          };
          final modelKey = prefMap[preference];
          if (modelKey != null && productDatabase[modelKey] != null) {
            ductedProducts.add(productDatabase[modelKey]!);
          }
        }
      }
    }

    return {
      'isDucted': defaultIsDucted,
      'ductlessProduct': ductlessProduct,
      'reasons': reasons,
      'mainFilter': mainFilter,
      'secondaryFilter': secondaryFilter,
      'unsupportedFilters': unsupportedFilters,
      'ductedProducts': ductedProducts,
      'multipleDuctedOptions':
          (ductedProducts.isEmpty &&
          (checklistValues.values.where((v) => v).length > 1)),
    };
  }
}

// A simple tuple class to help with sorting
class Tuple<T1, T2, T3, T4> {
  final T1 item1;
  final T2 item2;
  final T3 item3;
  final T4 item4;
  Tuple(this.item1, this.item2, this.item3, this.item4);
}
