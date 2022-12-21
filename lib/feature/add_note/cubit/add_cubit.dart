import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  void onTitleChanged(String title) {
    emit(state.copyWith(
      title: title,
    ));
  }

  void onTextChanged(String text) {
    emit(state.copyWith(
      text: text,
    ));
  }
}
