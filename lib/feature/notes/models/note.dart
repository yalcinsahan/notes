class Note {
  int? id;
  String? title;
  String? text;

  Note({this.id, this.title, this.text});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
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

  /* Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    return data;
  }*/
}
