import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AnimeCharacterPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;

  const AnimeCharacterPlaceholder({
    super.key,
    this.width = 150,
    this.height = 200,
    this.opacity = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.accentLight.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: height * 0.35,
              color: AppColors.accent,
            ),
            const SizedBox(height: 8),
            Text(
              'Character',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
