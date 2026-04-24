import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.navBarBackground,
        selectedItemColor: AppColors.navBarSelected,
        unselectedItemColor: AppColors.navBarUnselected,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: AppLocalizations.of(context)!.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_box_outlined),
            label: AppLocalizations.of(context)!.navTasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notes_rounded),
            label: AppLocalizations.of(context)!.navNotes,
          ),
        ],
      ),
    );
  }
}
