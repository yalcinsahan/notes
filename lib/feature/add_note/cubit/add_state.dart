part of 'add_cubit.dart';

class AddState extends Equatable {
  final String id;
  final String title;
  final String text;

  const AddState({this.id = '', this.title = '', this.text = ''});

  AddState copyWith({
    String? id,
    String? title,
    String? text,
  }) {
    return AddState(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [id, title, text];
}
