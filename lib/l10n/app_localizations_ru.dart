// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'AniTodoNotes';

  @override
  String get navHome => 'Главная';

  @override
  String get navTasks => 'Задачи';

  @override
  String get navNotes => 'Заметки';

  @override
  String get tasksTitle => 'Задачи';

  @override
  String get deleteTask => 'Удалить задачу';

  @override
  String get deleteTaskConfirm => 'Вы уверены, что хотите удалить эту задачу?';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get noTasksYet => 'Задач пока нет!\nНажмите + чтобы добавить.';

  @override
  String get editTask => 'Редактировать задачу';

  @override
  String get newTask => 'Новая задача';

  @override
  String get taskTitleHint => 'Название задачи...';

  @override
  String get priorityLabel => 'Приоритет: ';

  @override
  String dateLabel(String date) {
    return 'Дата:  $date';
  }

  @override
  String get update => 'Обновить';

  @override
  String get save => 'Сохранить';

  @override
  String get notesTitle => 'Заметки';

  @override
  String get noNotesYet => 'Заметок пока нет!\nНажмите + чтобы создать.';

  @override
  String get editNote => 'Редактировать заметку';

  @override
  String get newNote => 'Новая заметка';

  @override
  String get noteNameHint => 'Название...';

  @override
  String get noteTextHint => 'Текст... (поддерживает Markdown)';

  @override
  String get deleteNote => 'Удалить заметку';

  @override
  String get deleteNoteConfirm => 'Вы уверены, что хотите удалить эту заметку?';

  @override
  String get discardTask => 'Отменить изменения?';

  @override
  String get discardTaskConfirm => 'Есть несохранённые изменения. Отменить их?';

  @override
  String get discardNote => 'Отменить изменения?';

  @override
  String get discardNoteConfirm => 'Есть несохранённые изменения. Отменить их?';

  @override
  String get discard => 'Не сохранять';

  @override
  String get editTooltip => 'Редактировать';

  @override
  String get previewTooltip => 'Просмотр';

  @override
  String get nothingToPreview => '*Нет содержимого для просмотра*';

  @override
  String get untitled => 'Без названия';

  @override
  String lastEdit(String date) {
    return 'Последнее изменение: $date';
  }

  @override
  String todaysTasks(int count) {
    return 'Задачи на сегодня: $count';
  }

  @override
  String get noTasksToday => 'На сегодня задач нет!';

  @override
  String moreTasksCount(int count) {
    return '+ ещё $count';
  }

  @override
  String get changePicture => 'Изменить фото';

  @override
  String get removePicture => 'Удалить фото';

  @override
  String get tapForMore => 'НАЖМИТЕ для следующей';

  @override
  String get priorityLow => 'Низкий';

  @override
  String get priorityMedium => 'Средний';

  @override
  String get priorityHigh => 'Высокий';

  @override
  String get quote0 => 'Я всегда рядом с тобой!';

  @override
  String get quote1 => 'Ты отлично справляешься, продолжай!';

  @override
  String get quote2 => 'Шаг за шагом!';

  @override
  String get quote3 => 'Верь в себя!';

  @override
  String get quote4 => 'Сегодня отличный день, чтобы быть продуктивной!';

  @override
  String get quote5 => 'Маленький прогресс — тоже прогресс!';

  @override
  String get quote6 => 'У тебя всё получится!';

  @override
  String get quote7 => 'Сохраняй концентрацию и никогда не сдавайся!';

  @override
  String get quote8 => 'Каждая завершённая задача — это победа!';

  @override
  String get quote9 => 'Продолжай сиять!';
}
