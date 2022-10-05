import 'package:flutter_sqflite_study_sample/model/sample.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDataBase {
  static final SqlDataBase instance = SqlDataBase._instance();

  Database? _database;

  SqlDataBase._instance() {
    _initDataBase();
  }

  factory SqlDataBase() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await _initDataBase();
    return _database!;
  }

  Future<void> _initDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'sample.db');
    _database = await openDatabase(path, version: 2, onCreate: _dataBaseCreate);
  }

  void _dataBaseCreate(Database db, int version) async {
    await db.execute('''
      create table ${Sample.tableName} (
        ${SampleFields.id}  integer primary key autoincrement,
        ${SampleFields.name} text not null,
        ${SampleFields.yn} integer not null,
        ${SampleFields.value} double not null,
        ${SampleFields.createdAt} text not null)
      ''');
    //DateTime is not a supported SQLite type. Personally I store them as int (millisSinceEpoch) or string (iso8601)
    //bool is not a supported SQLite type. Use INTEGER and 0 and 1 values.
  }

  void closeDataBase() async {
    if (_database != null) await _database!.close();
  }
}
