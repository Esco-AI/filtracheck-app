import 'package:flutter/material.dart';
import 'frosted.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 900),
      tween: Tween(begin: 0.35, end: 0.9),
      curve: Curves.easeInOut,
      builder: (context, val, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Frosted(
            borderRadius: 18,
            blur: 14,
            tint: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Opacity(
                opacity: 0.6 + (val * 0.2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
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
