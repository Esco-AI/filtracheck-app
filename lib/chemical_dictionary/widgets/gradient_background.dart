import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.9, -1.0),
          end: Alignment(0.9, 1.0),
          colors: [Color(0xFF0D7AC8), Color(0xFF3AADEA)],
        ),
      ),
      child: Stack(
        children: const [
          _Blob(top: -120, left: -60, radius: 220, opacity: 0.18),
          _Blob(bottom: -80, right: -40, radius: 180, opacity: 0.16),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double radius;
  final double opacity;
  final double? top, left, right, bottom;

  const _Blob({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.radius,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: opacity * 0.7),
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
      ),
    );
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: dot,
    );
  }
}
