import 'package:notes/data/providers/note_provider.dart';
import 'package:notes/feature/notes/models/note.dart';

class NoteRepository {
  final NoteProvider noteProvider;

  NoteRepository({required this.noteProvider});

  Future<Note> insertNote(Note note) => noteProvider.insert(note);

  Future<List<Note>> getAllNotes() => noteProvider.getAllNotes();

  Future<int> updateNote(Note note) => noteProvider.updateNote(note);

  Future<int> deleteNote(int id) => noteProvider.deleteNote(id);
}
