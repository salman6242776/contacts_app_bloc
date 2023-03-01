import 'package:contact_app_bloc_architecture/common/di/get_it.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/domain/repository/contact_repository.dart';
import 'package:contact_app_bloc_architecture/data/helpers/db_helper.dart';
import 'package:contact_app_bloc_architecture/common/database_configuration.dart';
import 'package:sqflite/sqflite.dart';
import 'package:contact_app_bloc_architecture/common/constants.dart';

class ContactRepositoryService extends ContactRepository {
  // static ContactRepositoryService? _contactDataSource;
  // Database? _linkedTableWithDatabase;

  // final createTableQuery = 'CREATE TABLE ${TblContactsConfigration.tblName} ('
  //     ' ${TblContactsConfigration.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
  //     ' ${TblContactsConfigration.name} TEXT NOT NULL,'
  //     ' ${TblContactsConfigration.mobileNumber} TEXT,'
  //     ' ${TblContactsConfigration.landlineNumber} TEXT,'
  //     ' ${TblContactsConfigration.isFavorite} INTEGER NOT NULL,'
  //     ' ${TblContactsConfigration.profilePicture} TEXT'
  //     ' )';

  // ContactRepositoryService._();

  // static ContactRepositoryService getInstance() {
  //   _contactDataSource ??= ContactRepositoryService._();
  //   return _contactDataSource!;
  // }

  Future<Database> get linkedTableWithDatabase async {
    // _linkedTableWithDatabase ??=
    //     await DbHelper.getDatabase(Constants.databaseName, createTableQuery);
    return await locator.getAsync<Database>();
  }

  @override
  Future<List<ContactDataModel>> getAllContacts({
    String? where,
    List<Object>? whereArgs,
  }) async {
    final map = await DbHelper.getData(
      await linkedTableWithDatabase,
      TblContactsConfigration.tblName,
      orderBy: '${TblContactsConfigration.name} ASC',
      where: where,
      whereArgs: whereArgs,
    );
    return map
        .map((e) => ContactDataModel(
              id: e[TblContactsConfigration.id],
              name: e[TblContactsConfigration.name],
              mobileNumber: e[TblContactsConfigration.mobileNumber],
              landlineNumber: e[TblContactsConfigration.landlineNumber],
              profilePicture: e[TblContactsConfigration.profilePicture],
              isFavorite:
                  e[TblContactsConfigration.isFavorite] == 0 ? false : true,
            ))
        .toList();
  }

  @override
  Future<List<ContactDataModel>> getFavoriteContacts() {
    return getAllContacts(
      where: '${TblContactsConfigration.isFavorite} = ?',
      whereArgs: [1],
    );
  }

  // Future<ContactDataModel> getContactById(int id) async {

  // }
  @override
  Future<int> addContact(ContactDataModel contactDataModel) async {
    return DbHelper.insert(
      await linkedTableWithDatabase,
      TblContactsConfigration.tblName,
      {
        TblContactsConfigration.name: contactDataModel.name,
        TblContactsConfigration.mobileNumber: contactDataModel.mobileNumber,
        TblContactsConfigration.landlineNumber: contactDataModel.landlineNumber,
        TblContactsConfigration.isFavorite: contactDataModel.isFavorite,
        TblContactsConfigration.profilePicture: contactDataModel.profilePicture
      },
    );
  }
  // Future<bool> DeleteContact(int id) async{

  // }
  @override
  Future<int> editContact(ContactDataModel contactDataModel) async {
    return DbHelper.update(
      sqlDb: await linkedTableWithDatabase,
      tableName: TblContactsConfigration.tblName,
      where: '${TblContactsConfigration.id} = ?',
      whereArgs: [contactDataModel.id],
      data: {
        TblContactsConfigration.name: contactDataModel.name,
        TblContactsConfigration.mobileNumber: contactDataModel.mobileNumber,
        TblContactsConfigration.landlineNumber: contactDataModel.landlineNumber,
        TblContactsConfigration.isFavorite: contactDataModel.isFavorite,
        TblContactsConfigration.profilePicture: contactDataModel.profilePicture
      },
    );
  }

  @override
  Future<int> toggleFavorite(
      ContactDataModel contactDataModel, int newToggleValue) async {
    return DbHelper.update(
      sqlDb: await linkedTableWithDatabase,
      tableName: TblContactsConfigration.tblName,
      where: '${TblContactsConfigration.id} = ?',
      whereArgs: [contactDataModel.id],
      data: {
        TblContactsConfigration.isFavorite:
            newToggleValue, // used toggle value here to update favorite only!
      },
    );
  }

  @override
  Future<int> deleteContact(ContactDataModel contactDataModel) async {
    return DbHelper.delete(
      sqlDb: await linkedTableWithDatabase,
      tableName: TblContactsConfigration.tblName,
      where: '${TblContactsConfigration.id} = ?',
      whereArgs: [contactDataModel.id],
    );
  }
}
