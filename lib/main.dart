import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/providers/note_provider.dart';
import 'package:notes/data/repositories/note_repository.dart';
import 'package:notes/feature/notes/cubit/note_cubit.dart';
import 'package:notes/feature/notes/view/notes_page.dart';

void main() async {
  runApp(
    BlocProvider<NoteCubit>(
      create: (context) => NoteCubit(
        noteRepository: NoteRepository(
          noteProvider: NoteProvider(),
        ),
      )..fetchNotes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      home: NotesPage(),
    );
  }
}
