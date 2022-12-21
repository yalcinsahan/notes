import 'package:flutter_test/flutter_test.dart';
import 'package:notes/feature/notes/cubit/note_cubit.dart';
import 'package:notes/feature/notes/models/note.dart';

enum MockStatus { loading, success, failure }

void main() {
  group("NoteState", () {
    List<Note> mockNotes = [Note(id: 4, title: "title", text: "text")];

    test("supports value comparison", () {
      expect(const NoteState.loading(), const NoteState.loading());
      expect(NoteState.success(mockNotes), NoteState.success(mockNotes));
      expect(const NoteState.failure(), const NoteState.failure());
    });
  });
}
