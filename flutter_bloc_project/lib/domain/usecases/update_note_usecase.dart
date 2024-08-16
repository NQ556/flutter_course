import 'package:flutter_bloc_project/core/usecase/usecase.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateNoteUsecase implements Usecase<void, UpdateNoteParams> {
  final NoteRepository _noteRepository;
  UpdateNoteUsecase(this._noteRepository);

  @override
  Future<Either<Exception, void>> call(
    UpdateNoteParams params,
  ) async {
    return await _noteRepository.updateNote(
      note: params.note,
    );
  }
}

class UpdateNoteParams {
  final Note note;

  UpdateNoteParams({required this.note});
}
