import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  final double width;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.label,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 22;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 44,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white.withValues(alpha: 0.18),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 28,
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
