import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/colors.dart';
import 'package:notes/core/sizes.dart';
import 'package:notes/feature/add_note/view/adding_page.dart';
import 'package:notes/feature/notes/cubit/note_cubit.dart';
import '../models/note.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.brightGray,
        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            switch (state.status) {
              case NoteStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case NoteStatus.success:
                return noteList(context, state);

              case NoteStatus.failure:
                return errorAlert();

              default:
                return errorAlert();
            }
          },
        ),
        floatingActionButton: navigateButton(context),
      ),
    );
  }

  FloatingActionButton navigateButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(_createRoute(Note(id: 0, title: '', text: '')));
      },
      backgroundColor: AppColors.selectiveYellow,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Center errorAlert() =>
      const Center(child: Text("oops something went wrong..."));

  Center noteList(BuildContext context, NoteState state) {
    return Center(
        child: ListView.builder(
            padding: EdgeInsets.all(Sizes.perWidth(context) * 4),
            itemCount: state.notes.length,
            itemBuilder: (BuildContext context, int index) {
              return listItem(state, index, context);
            }));
  }

  Dismissible listItem(NoteState state, int index, BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(state.notes[index].id),
      onDismissed: (DismissDirection direction) {
        context.read<NoteCubit>().deleteNote(state.notes[index].id);
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(_createRoute(state.notes[index]));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(Sizes.perWidth(context) * 5),
          margin: EdgeInsets.symmetric(vertical: Sizes.perWidth(context) * 1.5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(state.notes[index].title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                state.notes[index].text,
                maxLines: 1,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Route _createRoute(Note note) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddingPage(note: note),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
