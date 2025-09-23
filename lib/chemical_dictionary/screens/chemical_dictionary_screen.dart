import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/chemical.dart';
import '../../services/chemical_service.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../widgets/action_chip.dart';
import '../widgets/badge.dart';
import '../widgets/chemical_card.dart';
import '../widgets/detail_row.dart';
import '../widgets/empty_state.dart';
import '../widgets/frosted.dart';
import '../widgets/search_bar.dart';
import '../widgets/skeleton_card.dart';

class ChemicalDictionaryScreen extends StatefulWidget {
  const ChemicalDictionaryScreen({super.key});

  @override
  State<ChemicalDictionaryScreen> createState() =>
      _ChemicalDictionaryScreenState();
}

class _ChemicalDictionaryScreenState extends State<ChemicalDictionaryScreen> {
  final ChemicalService _chemicalService = ChemicalService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  List<Chemical> _chemicals = [];
  List<Chemical> _filteredChemicals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadChemicals();
    _searchController.addListener(_filterChemicals);
  }

  Future<void> _loadChemicals() async {
    setState(() => _loading = true);
    await _chemicalService.initialize();
    _chemicals = _chemicalService.chemicals;
    _filteredChemicals = _chemicals;
    setState(() => _loading = false);
  }

  void _filterChemicals() {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() => _filteredChemicals = _chemicals);
      return;
    }
    setState(() {
      _filteredChemicals = _chemicals.where((c) {
        final name = c.name.toLowerCase();
        final cas = c.casNo.toLowerCase();
        final formula = c.formula.toLowerCase();
        return name.contains(q) || cas.contains(q) || formula.contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: const Text(
          'Chemical Dictionary',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: _loadChemicals,
          edgeOffset: 140,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(
                child: FrostedSearchBar(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  onClear: () {
                    _searchController.clear();
                    _filterChemicals();
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              if (_loading)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const SkeletonCard(),
                    childCount: 8,
                  ),
                )
              else if (_filteredChemicals.isEmpty)
                const SliverToBoxAdapter(child: EmptyState())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final chemical = _filteredChemicals[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 16,
                        bottom: index == _filteredChemicals.length - 1 ? 24 : 8,
                      ),
                      child: ChemicalCard(
                        chemical: chemical,
                        onTap: () => _showDetails(context, chemical),
                      ),
                    );
                  }, childCount: _filteredChemicals.length),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  void _showDetails(BuildContext context, Chemical c) {
    // This bottom sheet will need a redesign later if we continue
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final mq = MediaQuery.of(ctx);
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
            child: FrostedSheet(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        BadgePill(text: c.casNo.isEmpty ? 'No CAS' : c.casNo),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            c.name,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DetailRow(
                      label: 'Formula',
                      value: c.formula.isEmpty ? '—' : c.formula,
                    ),
                    const SizedBox(height: 8),
                    DetailRow(
                      label: 'Density (SG)',
                      value: (c.properties['SPECIFIC GRAVITY'] ?? '—')
                          .toString(),
                    ),
                    const SizedBox(height: 8),
                    DetailRow(
                      label: 'Molecular Weight',
                      value: (c.properties['MOLECULAR WEIGHT (MW)'] ?? '—')
                          .toString(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomActionChip(
                          icon: Icons.copy_all_rounded,
                          label: 'Copy CAS',
                          onTap: () {
                            if (c.casNo.isEmpty) return;
                            Clipboard.setData(ClipboardData(text: c.casNo));
                            Navigator.of(context).maybePop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('CAS copied')),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomActionChip(
                          icon: Icons.science_outlined,
                          label: 'Copy Formula',
                          onTap: () {
                            if (c.formula.isEmpty) return;
                            Clipboard.setData(ClipboardData(text: c.formula));
                            Navigator.of(context).maybePop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Formula copied')),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
