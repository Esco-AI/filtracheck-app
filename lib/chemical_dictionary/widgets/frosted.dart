import 'dart:ui';
import 'package:flutter/material.dart';

class Frosted extends StatelessWidget {
  final Widget child;
  final double blur;
  final double borderRadius;
  final Color? tint;
  final BoxBorder? border;

  const Frosted({
    super.key,
    required this.child,
    this.blur = 14,
    this.borderRadius = 16,
    this.tint,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: (tint ?? Colors.white.withValues(alpha: 0.06)),
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}

class FrostedSheet extends StatelessWidget {
  final Widget child;
  const FrostedSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Frosted(
      blur: 18,
      borderRadius: 24,
      tint: Colors.black.withValues(alpha: 0.25),
      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      child: child,
    );
  }
}
