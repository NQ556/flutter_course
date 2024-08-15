import 'package:flutter_bloc_project/data/model/note_model.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;
  late Future<Isar> database;
  DatabaseHelper._() {
    database = _init();
  }

  final BehaviorSubject<List<Note>> noteStreamController =
      BehaviorSubject<List<Note>>();

  Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [NoteModelSchema],
      directory: dir.path,
    );
  }
}
