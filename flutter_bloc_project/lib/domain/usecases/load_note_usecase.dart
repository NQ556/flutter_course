import 'package:flutter_bloc_project/core/usecase/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoadNoteUseCase implements Usecase<void, NoParams> {
  final NoteRepository _noteRepository;
  LoadNoteUseCase(this._noteRepository);

  @override
  Future<Either<Exception, void>> call(
    NoParams params,
  ) async {
    return await _noteRepository.loadNotes();
  }
}
