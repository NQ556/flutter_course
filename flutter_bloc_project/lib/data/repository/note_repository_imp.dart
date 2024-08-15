import 'package:flutter_bloc_project/data/datasource/note_datasource.dart';
import 'package:flutter_bloc_project/data/model/note_model.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:fpdart/fpdart.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource _noteDatasource;
  NoteRepositoryImpl(this._noteDatasource);

  @override
  Future<Either<Exception, void>> loadNotes() async {
    try {
      await _noteDatasource.loadNotes();
      return right(null);
    } on Exception catch (e) {
      return left(
        Exception(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, void>> addNote({
    required Note note,
  }) async {
    try {
      await _noteDatasource.addNote(
        noteModel: NoteModel.fromNote(note),
      );

      return right(null);
    } on Exception catch (e) {
      return left(
        Exception(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, void>> updateNote({
    required Note note,
  }) async {
    try {
      await _noteDatasource.updateNote(
        noteModel: NoteModel.fromNote(note),
      );
      return right(null);
    } on Exception catch (e) {
      return left(
        Exception(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, void>> deleteNote({required int id}) async {
    try {
      await _noteDatasource.deleteNote(id: id);
      return right(null);
    } on Exception catch (e) {
      return left(
        Exception(
          e.toString(),
        ),
      );
    }
  }
}
