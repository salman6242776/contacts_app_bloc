import 'package:contact_app_bloc_architecture/common/database_configuration.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/helpers/db_helper.dart';

class Repository {
  // List<ContactDataModel> getAllContacts() {
  //   return [
  //     ContactDataModel(
  //       id: 0,
  //       name: "name",
  //       mobileNumber: "mobileNumber",
  //       landlineNumber: "landlineNumber",
  //       profilePicture: "profilePicture",
  //     ),
  //     ContactDataModel(
  //       id: 0,
  //       name: "name2",
  //       mobileNumber: "mobileNumber2",
  //       landlineNumber: "landlineNumber2",
  //       profilePicture: "profilePicture2",
  //     ),
  //   ];
  // }
  Future<List<ContactDataModel>> getAllContacts({
    String? where,
    List<Object>? whereArgs,
  }) async {
    final map = await DbHelper.getData(
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

  Future<List<ContactDataModel>> getFavoriteContacts() {
    return getAllContacts(
      where: '${TblContactsConfigration.isFavorite} = ?',
      whereArgs: [1],
    );
  }

  // Future<ContactDataModel> getContactById(int id) async {

  // }

  Future<int> addContact(ContactDataModel contactDataModel) async {
    return DbHelper.insert(
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

  Future<int> editContact(ContactDataModel contactDataModel) async {
    return DbHelper.update(
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

  Future<int> toggleFavorite(
      ContactDataModel contactDataModel, int newToggleValue) async {
    return DbHelper.update(
      tableName: TblContactsConfigration.tblName,
      where: '${TblContactsConfigration.id} = ?',
      whereArgs: [contactDataModel.id],
      data: {
        TblContactsConfigration.isFavorite:
            newToggleValue, // used toggle value here to update favorite only!
      },
    );
  }

  Future<int> deleteContact(ContactDataModel contactDataModel) async {
    return DbHelper.delete(
      tableName: TblContactsConfigration.tblName,
      where: '${TblContactsConfigration.id} = ?',
      whereArgs: [contactDataModel.id],
    );
  }
}
