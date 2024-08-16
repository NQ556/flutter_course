import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:isar/isar.dart';
part 'note_model.g.dart';

@collection
class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.title,
    required super.content,
  });

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id ?? Isar.autoIncrement,
      title: note.title,
      content: note.content,
    );
  }
}
