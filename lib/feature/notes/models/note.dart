import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Note extends Equatable {
  late int id;
  late String title;
  late String text;

  Note({this.id = 0, this.title = '', this.text = ''});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'title': title,
      'text': text,
    };
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    text = map['text'];
  }

  @override
  List<Object> get props => [id, text, title];
}
