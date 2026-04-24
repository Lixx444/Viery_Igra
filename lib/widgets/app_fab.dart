import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AppFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add, size: 28),
    );
  }
}
