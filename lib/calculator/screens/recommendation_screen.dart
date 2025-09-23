import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../widgets/calc_button.dart';

class RecommendationScreen extends StatefulWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationScreen({super.key, required this.recommendation});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  String? _selectedSize;

  String getModelKey(Product product) {
    var entry = productDatabase.entries.firstWhere(
      (entry) => entry.value == product,
      orElse: () => const MapEntry(
        '',
        Product(name: '', imagePath: '', availableSizes: []),
      ),
    );
    return entry.key;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDucted = widget.recommendation['isDucted'] ?? false;
    final Product? ductlessProduct = widget.recommendation['ductlessProduct'];
    final List<Product> ductedProducts =
        widget.recommendation['ductedProducts'] ?? [];
    final Product? productToShow = isDucted
        ? (ductedProducts.isNotEmpty ? ductedProducts.first : null)
        : ductlessProduct;

    // Set initial dropdown value if not already set
    if (_selectedSize == null &&
        productToShow != null &&
        productToShow.availableSizes.isNotEmpty) {
      _selectedSize = productToShow.availableSizes.first;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: const Text(
          'Recommendation',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: productToShow == null
              ? _buildNoProductState(context)
              : _buildProductRecommendation(context, productToShow, isDucted),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  // --- Main Widget for Displaying the Product ---
  Widget _buildProductRecommendation(
    BuildContext context,
    Product product,
    bool isDucted,
  ) {
    final String? mainFilter = widget.recommendation['mainFilter'];
    final String? secondaryFilter = widget.recommendation['secondaryFilter'];
    final String modelKey = getModelKey(product);
    final String hoodType = isDucted
        ? "Ducted Fume Hood"
        : "Ductless Fume Hood";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Text(
          "Here's Your Recommended Fume Hood",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),

        // Product Image
        Container(
          height: 220,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            product.imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Product Name and Type
        Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          hoodType,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 24),

        // Specifications in Pills
        _buildSpecPills(modelKey, mainFilter, secondaryFilter, isDucted),
        const SizedBox(height: 24),

        // Size Selector
        _buildSizeSelector(product),
        const SizedBox(height: 24),

        // Action Button
        CalcButton(
          label: 'Learn More',
          onPressed: () {
            // TODO: Implement Learn More action
          },
        ),
      ],
    );
  }

  // --- Helper for Spec Pills ---
  Widget _buildSpecPills(
    String modelKey,
    String? mainFilter,
    String? secondaryFilter,
    bool isDucted,
  ) {
    if (isDucted) {
      return _InfoPill(label: 'Model Code', value: modelKey);
    }
    return Row(
      children: [
        Expanded(
          child: _InfoPill(label: 'Model Code', value: modelKey),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _InfoPill(
            label: 'Main Filter',
            value: mainFilter != null ? 'Type $mainFilter' : 'None',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _InfoPill(
            label: 'Secondary',
            value: secondaryFilter != null ? 'Type $secondaryFilter' : 'None',
          ),
        ),
      ],
    );
  }

  // --- Helper for Size Dropdown ---
  Widget _buildSizeSelector(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Choose Preferred Size:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedSize,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items: product.availableSizes
              .map(
                (size) => DropdownMenuItem(
                  value: size,
                  child: Text(
                    size,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedSize = value);
          },
        ),
      ],
    );
  }

  // --- Fallback Widget when no product is recommended ---
  Widget _buildNoProductState(BuildContext context) {
    String message =
        "Multiple options might be available. Please refine your preferences on the previous screen for a specific recommendation.";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Icon(
            Icons.biotech_outlined,
            color: Colors.white.withOpacity(0.8),
            size: 60,
          ),
          const SizedBox(height: 20),
          Text(
            "Further Input Required",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// A new, reusable widget for displaying spec info pills
class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
