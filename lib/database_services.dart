import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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

  //i make that private constructor to make sure that the class is singleton
  //so we can't create an object from it from outside the class
  //ensures that there is only one instance of DatabaseHelper throughout your application
  //this is important because you don't want to have multiple instances of the database helper class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
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
    Database db = await instance.database;
    print('inserting row');
    db.insert(table, row).then((value)
    {
      print('inserted row id: $value');
      return value;
    });
    return 0;
  }


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
