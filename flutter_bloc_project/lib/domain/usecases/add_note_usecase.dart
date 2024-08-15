import 'package:flutter_bloc_project/core/usecase/usecase.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddNoteUsecase implements Usecase<void, AddNoteParams> {
  final NoteRepository _noteRepository;
  AddNoteUsecase(this._noteRepository);

  @override
  Future<Either<Exception, void>> call(
    AddNoteParams params,
  ) async {
    return await _noteRepository.addNote(
      note: params.note,
    );
  }
}

class AddNoteParams {
  final Note note;
  AddNoteParams({required this.note});
}
