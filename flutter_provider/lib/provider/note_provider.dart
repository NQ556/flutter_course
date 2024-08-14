import 'package:flutter/material.dart';
import 'package:flutter_provider/common/database_helper.dart';
import 'package:flutter_provider/model/note.dart';

class NoteProvider extends ChangeNotifier {
  final _databaseHelper = DatabaseHelper();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> init() async {
    await loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = await _databaseHelper.loadNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    try {
      await _databaseHelper.addNote(note);
      await loadNotes();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _databaseHelper.deleteNote(id);
      await loadNotes();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
