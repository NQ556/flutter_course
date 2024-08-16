part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoadingState extends NoteState {}

final class GetNotesState extends NoteState {
  final List<Note> notes;
  GetNotesState({required this.notes});
}

final class AddNoteSuccessState extends NoteState {}

final class UpdateNoteSuccessState extends NoteState {}

final class DeleteNoteSuccessState extends NoteState {}

final class NoteFailureState extends NoteState {
  final String message;
  NoteFailureState({required this.message});
}
