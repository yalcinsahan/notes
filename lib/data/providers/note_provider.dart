import 'package:notes/feature/notes/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  String dbName = 'notes.db';
  String tableName = 'note';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnText = 'text';

  late Database db;

  Future open() async {
    var databasesPath = "${await getDatabasesPath()}/$dbName";
    db = await openDatabase(databasesPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''create table $tableName ($columnId integer primary key autoincrement, $columnTitle text,$columnText text)''');
    });
  }

  Future<Note> insert(Note note) async {
    note.id = await db.insert(tableName, note.toMap());
    return note;
  }

  Future<int> updateNote(Note note) async {
    return await db.update(tableName, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    return await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<List<Note>> getAllNotes() async {
    await open();

    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: "id DESC");

    return (List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        text: maps[i]['text'],
        title: maps[i]['title'],
      );
    }));
  }

  Future close() async => db.close();
}
