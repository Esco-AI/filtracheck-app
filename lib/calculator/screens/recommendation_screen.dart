import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../chemical_dictionary/widgets/frosted.dart';

class RecommendationScreen extends StatefulWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationScreen({super.key, required this.recommendation});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  String? _selectedSize;

  // Function to get the model key from the product object
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

    // Determine which product to show. For ducted, we'll just show the first one if multiple are possible.
    final Product? productToShow = isDucted
        ? (ductedProducts.isNotEmpty ? ductedProducts.first : null)
        : ductlessProduct;

    // Set initial dropdown value
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
          'Recommendation Result',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Frosted(
            borderRadius: 24,
            blur: 16,
            tint: Colors.blue,
            border: Border.all(color: Colors.blue.shade200),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: productToShow == null
                  ? _buildNoProductState(context, isDucted)
                  : _buildProductRecommendation(
                      context,
                      productToShow,
                      isDucted,
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  Widget _buildProductRecommendation(
    BuildContext context,
    Product product,
    bool isDucted,
  ) {
    final String? mainFilter = widget.recommendation['mainFilter'];
    final String? secondaryFilter = widget.recommendation['secondaryFilter'];
    int filterCount =
        (mainFilter != null ? 1 : 0) + (secondaryFilter != null ? 1 : 0);
    String modelKey = getModelKey(product);
    String hoodType = isDucted ? "Ducted Fume Hood" : "Ductless Fume Hood";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Product Type Header ---
        Text(
          hoodType,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // --- Product Image ---
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              product.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.inventory_2_outlined,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // --- Product Name ---
        Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // --- Specifications ---
        _infoRow('Model Code:', modelKey),
        _infoRow(
          'Main Filter:',
          isDucted ? 'N/A' : (mainFilter != null ? 'Type $mainFilter' : 'None'),
        ),
        _infoRow(
          'Secondary Filter:',
          isDucted
              ? 'N/A'
              : (secondaryFilter != null ? 'Type $secondaryFilter' : 'None'),
        ),
        _infoRow('No. of Filter:', isDucted ? 'N/A' : filterCount.toString()),

        const Divider(color: Colors.white24, height: 30),

        // --- Size Selector ---
        const Text(
          'Choose Preferred Size:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: _selectedSize,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
              size: 28,
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
              if (value != null) {
                setState(() => _selectedSize = value);
              }
            },
          ),
        ),
        const SizedBox(height: 20),

        // --- Action Button ---
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            // TODO: Handle Learn More action
          },
          child: const Text(
            'Learn More',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildNoProductState(BuildContext context, bool isDucted) {
    String message = isDucted
        ? "Multiple options are available. Please select your general preferences on the previous screen to narrow down the model recommendation."
        : "We couldn't determine a specific model for your needs. Please contact us for a consultation.";

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.help_outline, color: Colors.white, size: 50),
            const SizedBox(height: 16),
            Text(
              "Recommendation Pending",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
