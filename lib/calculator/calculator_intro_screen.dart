import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/bottom_navigation_bar.dart';

class CalculatorIntroScreen extends StatelessWidget {
  const CalculatorIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chemical Calculator',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Kindly list down all chemicals that you intend to use inside the fume hood.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  height: 180,
                  width: 220,
                  child: SvgPicture.asset(
                    'assets/images/calculator-chemical-icon.svg',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),

                _CalcButton(
                  label: 'Add Chemical',
                  onPressed: () {
                    // TODO: navigate to Add Chemical page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add Chemical tapped')),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _CalcButton(
                  label: 'Evaluate',
                  onPressed: () {
                    // TODO: navigate to Evaluate page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Evaluate tapped')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _CalcButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 240,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.28),
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
