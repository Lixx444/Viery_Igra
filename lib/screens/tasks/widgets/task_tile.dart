import 'package:flutter/material.dart';

import '../../../models/task.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/date_utils.dart' as app_date;
import '../../../widgets/glass_card.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final bool editMode;
  final VoidCallback onToggleComplete;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.task,
    this.editMode = false,
    required this.onToggleComplete,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Priority color dot + date number
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: task.priority.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${task.dueDate.day}',
                  style: TextStyle(
                    color: task.priority.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                app_date.formatDateShort(task.dueDate).split(' ').first,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: AppColors.textLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Edit mode actions or checkbox
          if (editMode) ...[
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              color: AppColors.accent,
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: AppColors.priorityHigh,
              onPressed: onDelete,
            ),
          ] else
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => onToggleComplete(),
            ),
        ],
      ),
    );
  }
}
