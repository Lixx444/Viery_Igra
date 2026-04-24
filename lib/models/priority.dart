import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../theme/app_colors.dart';

enum Priority {
  low,
  medium,
  high;

  Color get color {
    switch (this) {
      case Priority.low:
        return AppColors.priorityLow;
      case Priority.medium:
        return AppColors.priorityMedium;
      case Priority.high:
        return AppColors.priorityHigh;
    }
  }

  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case Priority.low:
        return l10n.priorityLow;
      case Priority.medium:
        return l10n.priorityMedium;
      case Priority.high:
        return l10n.priorityHigh;
    }
  }
}
