import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/common/database_helper.dart';
import 'package:flutter_bloc_project/common/manager/string_manager.dart';
import 'package:flutter_bloc_project/model/note.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this.databaseHelper) : super(NoteInitial());
  final DatabaseHelper databaseHelper;

  Future<void> loadNotes() async {
    try {
      final notes = await databaseHelper.loadNotes();
      emit(
        GetNotesState(
          notes: notes,
        ),
      );
    } catch (e) {
      emit(
        GetNotesState(
          notes: const [],
        ),
      );
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await databaseHelper.addNote(note);
      emit(AddNoteSuccessState());
    } catch (e) {
      emit(
        NoteFailureState(
          message: NotiManageer.addNoteFailure,
        ),
      );
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await databaseHelper.addNote(note);
      emit(UpdateNoteSuccessState());
    } catch (e) {
      emit(
        NoteFailureState(
          message: NotiManageer.updateNoteFailure,
        ),
      );
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await databaseHelper.deleteNote(id);
      emit(DeleteNoteSuccessState());
    } catch (e) {
      emit(
        NoteFailureState(
          message: NotiManageer.deleteNoteFailure,
        ),
      );
    }
  }
}
