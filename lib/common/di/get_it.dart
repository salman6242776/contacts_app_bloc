import 'package:contact_app_bloc_architecture/common/constants.dart';
import 'package:contact_app_bloc_architecture/data/service/contact_repository_service.dart';
import 'package:contact_app_bloc_architecture/common/database_configuration.dart';

import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var locator = GetIt.instance;

void setUpGetIt() {
  locator.registerLazySingleton(() => ContactRepositoryService());

  const createTableQuery = 'CREATE TABLE ${TblContactsConfigration.tblName} ('
      ' ${TblContactsConfigration.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' ${TblContactsConfigration.name} TEXT NOT NULL,'
      ' ${TblContactsConfigration.mobileNumber} TEXT,'
      ' ${TblContactsConfigration.landlineNumber} TEXT,'
      ' ${TblContactsConfigration.isFavorite} INTEGER NOT NULL,'
      ' ${TblContactsConfigration.profilePicture} TEXT'
      ' )';

  locator.registerLazySingletonAsync(
      () => _getDatabase(Constants.databaseName, createTableQuery));
}

Future<Database> _getDatabase(
    String databaseName, String createTableQuery) async {
  final dbPath = await getDatabasesPath();
  return await openDatabase(join(dbPath, databaseName),
      onCreate: (db, version) {
    return db.execute(createTableQuery);
  }, version: 1);
}
