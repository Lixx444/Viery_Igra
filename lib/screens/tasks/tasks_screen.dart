import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_fab.dart';
import 'task_add_edit_dialog.dart';
import 'widgets/task_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool _editMode = false;

  void _showAddEditDialog([Task? task]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => TaskAddEditDialog(task: task),
    );
  }

  void _confirmDelete(String taskId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteTask),
        content: Text(l10n.deleteTaskConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskProvider>().deleteTask(taskId);
              Navigator.pop(ctx);
            },
            child: Text(l10n.delete,
                style: const TextStyle(color: AppColors.priorityHigh)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tasksTitle),
        actions: [
          if (tasks.isNotEmpty)
            IconButton(
              icon: Icon(_editMode ? Icons.check : Icons.edit_outlined),
              onPressed: () => setState(() => _editMode = !_editMode),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final characterHeight = constraints.maxHeight * 0.4;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Character — flush with bottom
              Positioned(
                bottom: 75,
                right: 0,
                child: Image.asset(
                  'assets/images/characters/mirai_kuriyama.png',
                  height: characterHeight,
                  fit: BoxFit.contain,
                ),
              ),
              // Content
              if (tasks.isEmpty)
                Center(
                  child: Text(
                    l10n.noTasksYet,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 16,
                    ),
                  ),
                )
              else
                ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 80),
                  itemCount: tasks.length,
                  itemBuilder: (_, i) => TaskTile(
                    task: tasks[i],
                    editMode: _editMode,
                    onToggleComplete: () =>
                        context.read<TaskProvider>().toggleComplete(tasks[i].id),
                    onEdit: () => _showAddEditDialog(tasks[i]),
                    onDelete: () => _confirmDelete(tasks[i].id),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: AppFab(onPressed: () => _showAddEditDialog()),
    );
  }
}
