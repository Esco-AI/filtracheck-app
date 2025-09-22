import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalcIntroView extends StatelessWidget {
  const CalcIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Kindly list down all chemicals that you intend to use inside the fume hood.',
          textAlign: TextAlign.center,
          style: TextStyle(
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
        const SizedBox(height: 12),],
    );
  }
}
