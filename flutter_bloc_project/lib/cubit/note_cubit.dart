import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/core/db/database_helper.dart';
import 'package:flutter_bloc_project/core/manager/string_manager.dart';
import 'package:flutter_bloc_project/core/usecase/usecase.dart';
import 'package:flutter_bloc_project/domain/entity/note.dart';
import 'package:flutter_bloc_project/domain/usecases/add_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/load_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/update_note_usecase.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(
    this.addNoteUsecase,
    this.loadNoteUseCase,
    this.updateNoteUsecase,
    this.deleteNoteUsecase,
    this.databaseHelper,
  ) : super(NoteInitial());
  final AddNoteUsecase addNoteUsecase;
  final LoadNoteUseCase loadNoteUseCase;
  final UpdateNoteUsecase updateNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final DatabaseHelper databaseHelper;

  void loadNotes() async {
    final result = await loadNoteUseCase.call(
      NoParams(),
    );

    result.fold(
      (_) => emit(
        GetNotesState(
          notes: const [],
        ),
      ),
      (_) => _getNotes(),
    );
  }

  void addNote(Note note) async {
    final result = await addNoteUsecase.call(
      AddNoteParams(note: note),
    );

    result.fold(
      (_) => emit(
        NoteFailureState(
          message: NotiManageer.addNoteFailure,
        ),
      ),
      (_) => emit(
        AddNoteSuccessState(),
      ),
    );
  }

  void updateNote(Note note) async {
    final result = await updateNoteUsecase.call(
      UpdateNoteParams(note: note),
    );

    result.fold(
      (_) => emit(
        NoteFailureState(
          message: NotiManageer.updateNoteFailure,
        ),
      ),
      (_) => emit(
        UpdateNoteSuccessState(),
      ),
    );
  }

  void deleteNote(int id) async {
    final result = await deleteNoteUsecase.call(
      DeleteNoteParams(id: id),
    );

    result.fold(
      (_) => emit(
        NoteFailureState(
          message: NotiManageer.updateNoteFailure,
        ),
      ),
      (_) => emit(
        DeleteNoteSuccessState(),
      ),
    );
  }

  void _getNotes() {
    databaseHelper.noteStreamController.stream.listen(
      (notes) {
        emit(
          GetNotesState(notes: notes),
        );
      },
    );
  }
}
