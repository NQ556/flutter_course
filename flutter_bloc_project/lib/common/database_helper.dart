import 'package:flutter_bloc_project/model/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  late Future<Isar> database;
  DatabaseHelper._internal() {
    database = _init();
    loadNotes();
  }

  final BehaviorSubject<List<Note>> _noteStreamController =
      BehaviorSubject<List<Note>>();

  Stream<List<Note>> get noteStream => _noteStreamController.stream;

  Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  Future<void> loadNotes() async {
    try {
      final isar = await database;
      final notes = await isar.notes.where().findAll();
      _noteStreamController.add(notes);
    } catch (e) {
      _noteStreamController.add([]);
    }
  }

  Future<void> addNote(Note note) async {
    try {
      final isar = await database;
      await isar.writeTxn(() async {
        await isar.notes.put(note);
      });

      loadNotes();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      final isar = await database;
      await isar.writeTxn(() async {
        await isar.notes.delete(id);
      });

      loadNotes();
    } catch (e) {
      throw Exception();
    }
  }

  void dispose() {
    _noteStreamController.close();
  }
}
