import 'package:flutter_sqflite_study_sample/model/sample.dart';
import 'package:flutter_sqflite_study_sample/repository/sql_database.dart';

class SqlSampleCrudRepository {
  static Future<Sample> create(Sample sample) async {
    var db = await SqlDataBase.instance.database;
    var id = await db.insert(Sample.tableName, sample.toJson());
    return sample.clone(id: id);
  }

  static Future<List<Sample>> getList() async {
    var db = await SqlDataBase.instance.database;

    var results = await db.query(Sample.tableName,
        columns: [
          SampleFields.id,
          SampleFields.name,
          SampleFields.yn,
          SampleFields.createdAt,
        ],
        orderBy: '${SampleFields.createdAt} DESC');

    return results.map((data) => Sample.fromJson(data)).toList();
  }

  static Future<Sample?> getOne(int id) async {
    var db = await SqlDataBase.instance.database;

    var results = await db.query(
      Sample.tableName,
      columns: [
        SampleFields.id,
        SampleFields.name,
        SampleFields.yn,
        SampleFields.value,
        SampleFields.createdAt,
      ],
      where: '${SampleFields.id} = ?',
      whereArgs: [id],
    );
    var list = results.map((data) => Sample.fromJson(data)).toList();
    if (list.isNotEmpty) {
      return list.first;
    } else {
      return null;
    }
  }

  static Future<int> update(Sample sample) async {
    var db = await SqlDataBase.instance.database;
    return await db.update(
      Sample.tableName,
      sample.toJson(),
      where: '${SampleFields.id} = ?',
      whereArgs: [sample.id],
    );
  }

  static Future<int> delete(int id) async {
    var db = await SqlDataBase.instance.database;
    return await db.delete(
      Sample.tableName,
      where: '${SampleFields.id} = ?',
      whereArgs: [id],
    );
  }
}
