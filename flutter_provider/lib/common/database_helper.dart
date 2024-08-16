import 'package:flutter_provider/model/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  late Future<Isar> database;
  DatabaseHelper._internal() {
    database = _init();
  }

  Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  Future<void> addNote(Note note) async {
    try {
      final isar = await database;
      await isar.writeTxn(() {
        return isar.notes.put(note);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Note>> loadNotes() async {
    try {
      final isar = await database;
      return isar.notes.where().findAll();
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      final isar = await database;
      await isar.writeTxn(() async {
        return await isar.notes.delete(id);
      });
    } catch (e) {
      throw Exception();
    }
  }
}
