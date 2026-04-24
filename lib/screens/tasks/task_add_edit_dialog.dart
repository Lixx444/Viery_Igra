import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/priority.dart';
import '../../models/task.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/date_utils.dart' as app_date;

class TaskAddEditDialog extends StatefulWidget {
  final Task? task;

  const TaskAddEditDialog({super.key, this.task});

  @override
  State<TaskAddEditDialog> createState() => _TaskAddEditDialogState();
}

class _TaskAddEditDialogState extends State<TaskAddEditDialog> {
  late final TextEditingController _titleController;
  late DateTime _selectedDate;
  late Priority _selectedPriority;

  bool get isEditing => widget.task != null;

  bool get _hasUnsavedChanges {
    if (isEditing) {
      return _titleController.text.trim() != widget.task!.title.trim() ||
          _selectedDate != widget.task!.dueDate ||
          _selectedPriority != widget.task!.priority;
    }
    return _titleController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _selectedDate = widget.task?.dueDate ?? DateTime.now();
    _selectedPriority = widget.task?.priority ?? Priority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _handleDiscard() async {
    if (!_hasUnsavedChanges) {
      Navigator.pop(context);
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.discardTask),
        content: Text(l10n.discardTaskConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.discard,
                style: const TextStyle(color: AppColors.priorityHigh)),
          ),
        ],
      ),
    );
    if (shouldDiscard == true && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final provider = context.read<TaskProvider>();
    final now = DateTime.now();

    if (isEditing) {
      final updated = widget.task!.copyWith(
        title: title,
        dueDate: _selectedDate,
        priority: _selectedPriority,
        updatedAt: now,
      );
      provider.updateTask(updated);
    } else {
      final task = Task(
        id: const Uuid().v4(),
        title: title,
        dueDate: _selectedDate,
        priority: _selectedPriority,
        createdAt: now,
        updatedAt: now,
      );
      provider.addTask(task);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleDiscard();
      },
      child: Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEditing ? l10n.editTask : l10n.newTask,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textLight),
                onPressed: _handleDiscard,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title field
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n.taskTitleHint,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 16),
          // Date picker
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dashedBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Text(
                    l10n.dateLabel(app_date.formatDateShort(_selectedDate)),
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Priority selector
          Row(
            children: [
              Text(l10n.priorityLabel,
                  style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(width: 8),
              ...Priority.values.map((p) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPriority = p),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: p.color.withValues(
                              alpha: _selectedPriority == p ? 1.0 : 0.3),
                          shape: BoxShape.circle,
                          border: _selectedPriority == p
                              ? Border.all(color: p.color, width: 2)
                              : null,
                        ),
                        child: _selectedPriority == p
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 24),
          // Save button
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(isEditing ? l10n.update : l10n.save),
          ),
        ],
      ),
    ));
  }
}
