import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/colors.dart';
import 'package:notes/feature/add_note/cubit/add_cubit.dart';
import 'package:notes/feature/notes/cubit/note_cubit.dart';

import '../../notes/models/note.dart';

class AddingPage extends StatelessWidget {
  const AddingPage({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddCubit(),
      child: BlocBuilder<AddCubit, AddState>(builder: (context, addState) {
        return SafeArea(
          child: Scaffold(
            body: inputs(addState, context),
            floatingActionButton: addButton(context, addState),
            backgroundColor: AppColors.brightGray,
            resizeToAvoidBottomInset: false,
          ),
        );
      }),
    );
  }

  FloatingActionButton addButton(BuildContext context, AddState addState) {
    return FloatingActionButton(
      onPressed: () {
        if (note.id > 0) {
          BlocProvider.of<NoteCubit>(context).updateNote(Note(
              id: note.id,
              text: addState.text.isNotEmpty ? addState.text : note.text,
              title: addState.title.isNotEmpty ? addState.title : note.title));
        } else {
          BlocProvider.of<NoteCubit>(context)
              .addNote(Note(id: 0, title: addState.title, text: addState.text));
        }

        Navigator.pop(context);
      },
      backgroundColor: AppColors.selectiveYellow,
      child: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  Padding inputs(AddState addState, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (50 / 945),
          vertical: MediaQuery.of(context).size.width * (70 / 945)),
      child: Column(
        children: [
          titleInput(context),
          textInput(context),
        ],
      ),
    );
  }

  Padding textInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        initialValue: note.text,
        onChanged: (value) {
          context.read<AddCubit>().onTextChanged(value);
        },
        decoration: const InputDecoration.collapsed(
          border: InputBorder.none,
          hintText: 'Text',
        ),
      ),
    );
  }

  TextFormField titleInput(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: note.title,
      onChanged: (value) {
        context.read<AddCubit>().onTitleChanged(value);
      },
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      decoration: const InputDecoration.collapsed(
        border: InputBorder.none,
        hintText: 'Title',
      ),
    );
  }
}
