import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/data/providers/note_provider.dart';
import 'package:notes/data/repositories/note_repository.dart';
import 'package:notes/feature/notes/cubit/note_cubit.dart';
import 'package:notes/feature/notes/models/note.dart';

class MockNoteProvider extends Mock implements NoteProvider {}

class MockNoteRepository extends Mock implements NoteRepository {
  final MockNoteProvider mockNoteProvider;
  MockNoteRepository({required this.mockNoteProvider});
}

void main() {
  group("NoteCubit", () {
    late NoteRepository noteRepository;

    setUp(() {
      noteRepository = MockNoteRepository(mockNoteProvider: MockNoteProvider());
    });

    test('initial state is NoteState.loading', () {
      expect(
        NoteCubit(noteRepository: noteRepository).state,
        const NoteState.loading(),
      );
    });

    group('fetchNotes', () {
      List<Note> mockNotes = [
        Note(id: 1, title: 'bir', text: 'one'),
        Note(id: 2, title: 'iki', text: 'two'),
        Note(id: 3, title: 'üç', text: 'three'),
      ];

      blocTest<NoteCubit, NoteState>(
        'emits NoteState.success after fetching list',
        setUp: () {
          when(noteRepository.getAllNotes).thenAnswer((_) async => mockNotes);
        },
        build: () => NoteCubit(noteRepository: noteRepository),
        act: (cubit) => cubit.fetchNotes(),
        expect: () => [
          NoteState.success(mockNotes),
        ],
        verify: (_) => verify(noteRepository.getAllNotes).called(1),
      );
    });

    group('deleteNote', () {
      List<Note> mockNotes = [
        Note(id: 1, title: 'bir', text: 'one'),
        Note(id: 2, title: 'iki', text: 'two'),
        Note(id: 3, title: 'üç', text: 'three'),
      ];

      blocTest<NoteCubit, NoteState>(
        'emits corrects states when deleting an note',
        setUp: () {
          when(() => noteRepository.deleteNote(2)).thenAnswer((_) async => 2);
        },
        build: () => NoteCubit(noteRepository: noteRepository),
        seed: () => NoteState.success(mockNotes),
        act: (cubit) => cubit.deleteNote(2),
        expect: () => [
          NoteState.success([
            Note(id: 1, title: 'bir', text: 'one'),
            Note(id: 3, title: 'üç', text: 'three'),
          ]),
        ],
        verify: (_) => verify(() => noteRepository.deleteNote(2)).called(1),
      );
    });

    group('addNote', () {
      List<Note> mockNotes = [
        Note(id: 1, title: 'bir', text: 'one'),
        Note(id: 2, title: 'iki', text: 'two'),
        Note(id: 3, title: 'üç', text: 'three'),
      ];

      Note mockNote = Note(id: 6, title: "altı", text: "siz");

      blocTest<NoteCubit, NoteState>(
        'emits corrects states when adding an note',
        setUp: () {
          when(() => noteRepository.insertNote(mockNote))
              .thenAnswer((_) async => mockNote);
        },
        build: () => NoteCubit(noteRepository: noteRepository),
        act: (cubit) => cubit.addNote(mockNote),
        seed: () => NoteState.success(mockNotes),
        expect: () {
          mockNotes.insert(0, mockNote);
          return [NoteState.success(mockNotes)];
        },
        verify: (_) =>
            verify(() => noteRepository.insertNote(mockNote)).called(1),
      );
    });

    group('updateNote', () {
      List<Note> mockNotes = [
        Note(id: 1, title: 'bir', text: 'one'),
        Note(id: 2, title: 'iki', text: 'two'),
        Note(id: 3, title: 'üç', text: 'three'),
      ];

      blocTest<NoteCubit, NoteState>(
        'emits corrects states when updating an note',
        setUp: () {
          when(() => noteRepository
                  .updateNote(Note(id: 2, title: 'bi2', text: 'one2')))
              .thenAnswer((_) async => 2);
        },
        build: () => NoteCubit(noteRepository: noteRepository),
        seed: () => NoteState.success(mockNotes),
        act: (cubit) =>
            cubit.updateNote(Note(id: 2, title: 'bi2', text: 'one2')),
        expect: () => [
          NoteState.success([
            Note(id: 1, title: 'bir', text: 'one'),
            Note(id: 2, title: 'bi2', text: 'one2'),
            Note(id: 3, title: 'üç', text: 'three'),
          ]),
        ],
        verify: (_) => verify(() => noteRepository
            .updateNote(Note(id: 2, title: 'bi2', text: 'one2'))).called(1),
      );
    });
  });
}
