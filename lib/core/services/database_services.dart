import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'todo';

  static const columnId = '_id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnDate = 'date';
  static const columnStartTime = 'start_time';
  static const columnEndTime = 'end_time';
  static const columnReminder = 'reminder';
  static const columnRepeat = 'repeat';
  static const columnColor = 'color';
  static const columnIsCompleted = 'is_completed';

  final DatabaseFactory databaseFactory = databaseFactoryFfi;

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> initDesktopDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
      version: _databaseVersion,
      onCreate: _onCreate,
    ));
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT, 
      $columnDescription TEXT, 
      $columnDate TEXT, 
      $columnStartTime TEXT, 
      $columnEndTime TEXT, 
      $columnReminder INTEGER, 
      $columnRepeat TEXT, 
      $columnColor INTEGER, 
      $columnIsCompleted INTEGER
    )
  ''');
    print('Table created');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await initDatabase(); // Example usage to ensure database is initialized
    print('inserting row');
    var id = await db.insert(table, row);
    return id;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await initDatabase(); // Example usage to ensure database is initialized
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await initDatabase(); // Example usage to ensure database is initialized
    int id = row[columnId];
    var update = await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
    print('updated row id: $update');
    return update;
  }

  Future<int> delete(int id) async {
    Database db = await initDatabase();
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> searchTasks(String query) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: '$columnTitle LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results;
  }
}
