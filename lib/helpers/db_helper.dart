import 'package:contact_app_bloc_architecture/common/constants.dart';
import 'package:contact_app_bloc_architecture/common/database_configuration.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DbHelper {
  // ignore: prefer_interpolation_to_compose_strings
  static const _createTableQuery =
      'CREATE TABLE ${TblContactsConfigration.tblName} ('
      ' ${TblContactsConfigration.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' ${TblContactsConfigration.name} TEXT NOT NULL,'
      ' ${TblContactsConfigration.mobileNumber} TEXT,'
      ' ${TblContactsConfigration.landlineNumber} TEXT,'
      ' ${TblContactsConfigration.isFavorite} INTEGER NOT NULL,'
      ' ${TblContactsConfigration.profilePicture} TEXT'
      ' )';

  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, Constants.databaseName),
        onCreate: (db, version) {
      return db.execute(_createTableQuery);
    }, version: 1);
  }

  static Future<int> insert(String tableName, Map<String, Object> data) async {
// returns true when insert is successful

    final sqlDb = await getDatabase();
    final insert = sqlDb.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // insert.then((value) => print('Value inserted: $value'));
    return insert;
  }

  static Future<int> update(
      {required String tableName,
      required String where,
      required List<dynamic> whereArgs,
      required Map<String, Object> data}) async {
// returns true when insert is successful

    final sqlDb = await getDatabase();
    final insert = sqlDb.update(
      tableName,
      data,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // insert.then((value) => print('Value inserted: $value'));
    return insert;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await getDatabase();
    return sqlDb.query(table);
  }
}
