import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final DatabaseHelper _db = DatabaseHelper.instance;

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get todaysTasks {
    final now = DateTime.now();
    return _tasks.where((t) {
      return t.dueDate.year == now.year &&
          t.dueDate.month == now.month &&
          t.dueDate.day == now.day;
    }).toList();
  }

  int get todaysTaskCount => todaysTasks.length;

  Future<void> loadTasks() async {
    _tasks = await _db.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _db.insertTask(task);
    _tasks.add(task);
    _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _db.updateTask(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
    _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await _db.deleteTask(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Future<void> toggleComplete(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;
    final task = _tasks[index];
    final updated = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );
    _tasks[index] = updated;
    await _db.updateTask(updated);
    notifyListeners();
  }
}
