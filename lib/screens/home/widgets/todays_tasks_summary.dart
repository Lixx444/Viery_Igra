import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/task_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/glass_card.dart';

class TodaysTasksSummary extends StatelessWidget {
  const TodaysTasksSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final todaysTasks = taskProvider.todaysTasks;
    final count = taskProvider.todaysTaskCount;
    final l10n = AppLocalizations.of(context)!;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.todaysTasks(count),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          if (todaysTasks.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                l10n.noTasksToday,
                style: const TextStyle(color: AppColors.textLight, fontSize: 14),
              ),
            )
          else
            ...todaysTasks.take(5).map((task) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) =>
                              context.read<TaskProvider>().toggleComplete(task.id),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.textLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
          if (todaysTasks.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.moreTasksCount(todaysTasks.length - 5),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textLight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
