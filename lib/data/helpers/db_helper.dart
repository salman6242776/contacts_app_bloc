import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

class DbHelper {
  // static Future<Database> getDatabase(
  //     String databaseName, String createTableQuery) async {
  //   final dbPath = await getDatabasesPath();
  //   return await openDatabase(join(dbPath, databaseName),
  //       onCreate: (db, version) {
  //     return db.execute(createTableQuery);
  //   }, version: 1);
  // }

  static Future<int> insert(
      Database sqlDb, String tableName, Map<String, Object> data) async {
// returns true when insert is successful

    final insert = sqlDb.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // insert.then((value) => print('Value inserted: $value'));
    return insert;
  }

  static Future<int> update(
      {required Database sqlDb,
      required String tableName,
      required String where,
      required List<dynamic> whereArgs,
      required Map<String, Object> data}) async {
// returns true when update is successful
    final insert = sqlDb.update(
      tableName,
      data,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insert;
  }

  static Future<int> delete(
      {required Database sqlDb,
      required String tableName,
      required String where,
      required List<dynamic> whereArgs}) async {
// returns true when delete is successful

    final insert = sqlDb.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return insert;
  }

  static Future<List<Map<String, dynamic>>> getData(
      Database sqlDb, String table,
      {String? orderBy, String? where, List<Object>? whereArgs}) async {
    return sqlDb.query(table,
        orderBy: orderBy, where: where, whereArgs: whereArgs);
  }
}
