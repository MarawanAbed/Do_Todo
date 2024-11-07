import 'dart:async';
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
  static const columnTime = 'time';
  static const columnColor = 'color';
  static const columnAmount = 'amount';
  static const columnIsChild = 'isChild';


  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle TEXT,
      $columnDescription TEXT,
      $columnDate TEXT,
      $columnTime TEXT,
      $columnColor INTEGER,
      $columnAmount REAL,
      $columnIsChild INTEGER
    )
  ''');
    print('Table created');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await initDatabase();
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await initDatabase();
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await initDatabase();
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await initDatabase();
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteExistingDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DatabaseHelper._databaseName);
    await deleteDatabase(path);
  }
}