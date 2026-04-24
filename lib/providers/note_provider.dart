import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  final DatabaseHelper _db = DatabaseHelper.instance;

  List<Note> get notes => List.unmodifiable(_notes);

  Future<void> loadNotes() async {
    _notes = await _db.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _db.insertNote(note);
    _notes.insert(0, note);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await _db.updateNote(note);
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) _notes[index] = note;
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    await _db.deleteNote(id);
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
