import 'package:flutter_bloc_project/core/usecase/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteNoteUsecase implements Usecase<void, DeleteNoteParams> {
  final NoteRepository _noteRepository;
  DeleteNoteUsecase(this._noteRepository);

  @override
  Future<Either<Exception, void>> call(
    DeleteNoteParams params,
  ) async {
    return await _noteRepository.deleteNote(
      id: params.id,
    );
  }
}

class DeleteNoteParams {
  final int id;

  DeleteNoteParams({required this.id});
}
