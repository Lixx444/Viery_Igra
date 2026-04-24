// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AniTodoNotes';

  @override
  String get navHome => 'Home';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navNotes => 'Notes';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String get deleteTaskConfirm => 'Are you sure you want to delete this task?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noTasksYet => 'No tasks yet!\nTap + to add one.';

  @override
  String get editTask => 'Edit Task';

  @override
  String get newTask => 'New Task';

  @override
  String get taskTitleHint => 'Task title...';

  @override
  String get priorityLabel => 'Priority: ';

  @override
  String dateLabel(String date) {
    return 'Date:  $date';
  }

  @override
  String get update => 'Update';

  @override
  String get save => 'Save';

  @override
  String get notesTitle => 'Notes';

  @override
  String get noNotesYet => 'No notes yet!\nTap + to create one.';

  @override
  String get editNote => 'Edit Note';

  @override
  String get newNote => 'New Note';

  @override
  String get noteNameHint => 'Name...';

  @override
  String get noteTextHint => 'Text... (supports Markdown)';

  @override
  String get deleteNote => 'Delete Note';

  @override
  String get deleteNoteConfirm => 'Are you sure you want to delete this note?';

  @override
  String get discardTask => 'Discard Task?';

  @override
  String get discardTaskConfirm => 'You have unsaved changes. Discard them?';

  @override
  String get discardNote => 'Discard Note?';

  @override
  String get discardNoteConfirm => 'You have unsaved changes. Discard them?';

  @override
  String get discard => 'Discard';

  @override
  String get editTooltip => 'Edit';

  @override
  String get previewTooltip => 'Preview';

  @override
  String get nothingToPreview => '*Nothing to preview*';

  @override
  String get untitled => 'Untitled';

  @override
  String lastEdit(String date) {
    return 'Last edit: $date';
  }

  @override
  String todaysTasks(int count) {
    return 'Today\'s Tasks: $count';
  }

  @override
  String get noTasksToday => 'No tasks for today!';

  @override
  String moreTasksCount(int count) {
    return '+ $count more';
  }

  @override
  String get changePicture => 'Change picture';

  @override
  String get removePicture => 'Remove picture';

  @override
  String get tapForMore => 'TAP for more';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get quote0 => 'I\'\'m always with you!';

  @override
  String get quote1 => 'You\'\'re doing great, keep going!';

  @override
  String get quote2 => 'One step at a time!';

  @override
  String get quote3 => 'Believe in yourself!';

  @override
  String get quote4 => 'Today is a good day to be productive!';

  @override
  String get quote5 => 'Small progress is still progress!';

  @override
  String get quote6 => 'You\'\'ve got this!';

  @override
  String get quote7 => 'Stay focused and never give up!';

  @override
  String get quote8 => 'Every task completed is a victory!';

  @override
  String get quote9 => 'Keep shining bright!';
}
