import 'package:flutter_bloc_project/core/db/database_helper.dart';
import 'package:flutter_bloc_project/data/model/note_model.dart';
import 'package:isar/isar.dart';

abstract interface class NoteDatasource {
  Future<void> loadNotes();

  Future<void> addNote({
    required NoteModel noteModel,
  });

  Future<void> updateNote({
    required NoteModel noteModel,
  });

  Future<void> deleteNote({
    required id,
  });
}

class NoteDatasourceImpl implements NoteDatasource {
  final DatabaseHelper _databaseHelper;

  NoteDatasourceImpl(
    this._databaseHelper,
  );

  @override
  Future<void> loadNotes() async {
    try {
      final db = await _databaseHelper.database;
      final notes = await db.noteModels.where().findAll();
      _databaseHelper.noteStreamController.add(notes);
    } catch (e) {
      _databaseHelper.noteStreamController.add([]);

      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addNote({required NoteModel noteModel}) async {
    try {
      final db = await _databaseHelper.database;
      await db.writeTxn(() async {
        await db.noteModels.put(noteModel);
      });

      loadNotes();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> updateNote({required NoteModel noteModel}) async {
    try {
      final db = await _databaseHelper.database;
      await db.writeTxn(() async {
        await db.noteModels.put(noteModel);
      });

      loadNotes();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> deleteNote({required id}) async {
    try {
      final db = await _databaseHelper.database;
      await db.writeTxn(() async {
        await db.noteModels.delete(id);
      });

      loadNotes();
    } catch (e) {
      throw Exception();
    }
  }
}
