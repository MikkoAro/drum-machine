import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/MainUI.dart';

String path;
Database database;

getPath() async {
  var databasesPath = await getDatabasesPath();
  path = join(databasesPath, 'pattern.db');
  initDatabase();
}

initDatabase() async {
  database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('CREATE TABLE Pattern (id INTEGER, pattern TEXT)');
  });
}

checkId(patternData) async {
  List<Map> set = await database.rawQuery('SELECT id FROM Pattern');
  String idTable = set.toString();
  //TODO make it beautiful
  if (!idTable.contains('1}')) {
    insert(patternData, 1);
  } else if (!idTable.contains('2')) {
    insert(patternData, 2);
  } else if (!idTable.contains('3')) {
    insert(patternData, 3);
  } else if (!idTable.contains('4')) {
    insert(patternData, 4);
  } else if (!idTable.contains('5')) {
    insert(patternData, 5);
  } else if (!idTable.contains('6')) {
    insert(patternData, 6);
  } else if (!idTable.contains('7')) {
    insert(patternData, 7);
  } else if (!idTable.contains('8')) {
    insert(patternData, 8);
  } else if (!idTable.contains('9')) {
    insert(patternData, 9);
  } else if (!idTable.contains('10')) {
    insert(patternData, 10);
  } else {
    infoToaster("No free slots for saving");
  }
}

insert(patternData, id) async {

  await database.transaction((txn) async {
    await txn.rawInsert(
        "INSERT INTO Pattern(id, pattern) VALUES($id, '$patternData')");
    infoToaster("Saved on slot $id");
  });
  print(id.toString() + patternData);
}

Future<List<Map>> fetch(id) async {
  List<Map> list =
      await database.rawQuery('SELECT Pattern FROM Pattern where id = $id');
  return list;
}

deleteSlot(id) {
  database.rawQuery('DELETE FROM pattern WHERE id=$id');
  infoToaster("Deleted slot $id");
}
