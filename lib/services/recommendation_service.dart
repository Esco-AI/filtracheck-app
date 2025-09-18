import 'package:filtracheck_v2/models/chemical.dart';

class RecommendationService {
  static Map<String, dynamic> evaluate(
    List<ChemicalSelection> selections,
    bool involvesHeating,
    Map<String, bool> checklistValues,
  ) {
    // --- Step 1: Initial Analysis ---
    final Set<String> distinctFilters = {};
    final Map<String, double> weightedSumQF = {};
    final Map<String, int> filterOccurrenceCounts = {};

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
    }

    // --- Step 2: Determine Fume Hood Type (Ducted vs. Ductless) ---
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

    // --- Step 3: Calculate Filter Dominance for Ductless Hood ---
    String? mainFilter;
    String? secondaryFilter;
    List<String> unsupportedFilters = [];

    if (!defaultIsDucted && distinctFilters.isNotEmpty) {
      // Create a list of tuples: [filter, score, occurrence, weightedSum]
      final ranking = distinctFilters.map((key) {
        final n = filterOccurrenceCounts[key] ?? 0;
        final s = weightedSumQF[key] ?? 0.0;
        final score = s * n;
        return Tuple(key, score, n, s);
      }).toList();

      // Sort by score (desc), then occurrence (desc), then sum (desc), then alphabetically
      ranking.sort((a, b) {
        int scoreComp = b.item2.compareTo(a.item2);
        if (scoreComp != 0) return scoreComp;
        int nComp = b.item3.compareTo(a.item3);
        if (nComp != 0) return nComp;
        int sComp = b.item4.compareTo(a.item4);
        if (sComp != 0) return sComp;
        return a.item1.compareTo(b.item1);
      });

      if (ranking.isNotEmpty) {
        mainFilter = ranking[0].item1;
      }
      if (ranking.length > 1) {
        secondaryFilter = ranking[1].item1;
      }
      if (ranking.length > 2) {
        unsupportedFilters = ranking.sublist(2).map((t) => t.item1).toList();
      }
    }

    return {
      'isDucted': defaultIsDucted,
      'reasons': reasons,
      'distinctFilters': distinctFilters.toList(),
      'mainFilter': mainFilter,
      'secondaryFilter': secondaryFilter,
      'unsupportedFilters': unsupportedFilters,
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
