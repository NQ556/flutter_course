import 'package:flutter_sqlite/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  late Future<Database> database;
  DatabaseHelper._internal() {
    database = _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'test_database.db',
    );
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(Note note) async {
    try {
      final db = await database;
      await db.insert('notes', note.toMap());
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<Note>> loadNotes() async {
    try {
      final db = await database;
      final result = await db.query('notes');
      return result.map((e) => Note.fromMap(e)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final db = await database;
      await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      final db = await database;
      await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception();
    }
  }
}
