import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repositories/note_repository.dart';
import 'package:notes/feature/notes/models/note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository noteRepository = NoteRepository();

  NoteCubit() : super(const NoteState.loading());

  Future<void> fetchNotes() async {
    try {
      final notes = await noteRepository.getAllNotes();
      emit(NoteState.success(notes.reversed.toList()));
    } on Exception {
      emit(const NoteState.failure());
    }
  }

  Future<void> addNote(String title, String text) async {
    final result =
        await noteRepository.insertNote(Note(title: title, text: text));

    if (result.id! > 0) {
      List<Note> addInProgress = state.notes.toList();
      addInProgress.insert(0, result);

      emit(NoteState.success(addInProgress));
    }
  }

  Future<void> updateNote(Note note) async {
    final result = await noteRepository.updateNote(note);

    if (result > 0) {
      emit(NoteState.success(
          state.notes.map((e) => e.id == note.id ? note : e).toList()));
    }
  }

  Future<void> deleteNote(int id) async {
    final result = await noteRepository.deleteNote(id);

    if (result > 0) {
      List<Note> deleteInProgress = state.notes.toList();
      deleteInProgress.removeWhere((item) => item.id == id);

      emit(NoteState.success(deleteInProgress));
    }
  }
}
