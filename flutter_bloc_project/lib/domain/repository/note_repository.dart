import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class NoteRepository {
  Future<Either<Exception, void>> loadNotes();

  Future<Either<Exception, void>> addNote({
    required Note note,
  });

  Future<Either<Exception, void>> updateNote({
    required Note note,
  });

  Future<Either<Exception, void>> deleteNote({
    required int id,
  });
}
