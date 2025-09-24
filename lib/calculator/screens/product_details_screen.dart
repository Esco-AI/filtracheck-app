import 'dart:ui';

import 'package:flutter/material.dart';
import '../../data/product_specifications.dart';
import '../../models/product.dart';
import '../../models/product_details.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../widgets/calc_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  String getModelKey(Product product) {
    var entry = productDatabase.entries.firstWhere(
      (entry) => entry.value.name == product.name,
      orElse: () => const MapEntry(
        '',
        Product(name: '', imagePath: '', availableSizes: []),
      ),
    );
    return entry.key;
  }

  @override
  Widget build(BuildContext context) {
    final String modelKey = getModelKey(product);
    final ProductDetails? details = productSpecifications[modelKey];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: const Text(
          'Product Details',
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
          child: details == null
              ? const Center(
                  child: Text(
                    'Details not found.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      details.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 220,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  radius: 0.53,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.40),
                                    Colors.white.withValues(alpha: 0.00),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 18,
                              sigmaY: 18,
                            ),
                            child: Opacity(
                              opacity: 0.25,
                              child: Image.asset(
                                product.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          Image.asset(
                            product.imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.inventory_2_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Key Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...details.specifications.map(
                      (spec) => _buildSpecRow(spec),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CalcButton(
                          label: 'Online Brochure',
                          onPressed: () {
                            // TODO: Implement brochure action
                          },
                        ),
                        const SizedBox(height: 12),
                        CalcButton(
                          label: 'Request a Quote',
                          onPressed: () {
                            // TODO: Implement quote action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Widget _buildSpecRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
