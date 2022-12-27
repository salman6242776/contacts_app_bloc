import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

class Repository {
  List<ContactDataModel> getAllContacts() {
    return [
      ContactDataModel(
        id: 0,
        name: "name",
        mobileNumber: "mobileNumber",
        landlineNumber: "landlineNumber",
        profilePicture: "profilePicture",
      ),
      ContactDataModel(
        id: 0,
        name: "name2",
        mobileNumber: "mobileNumber2",
        landlineNumber: "landlineNumber2",
        profilePicture: "profilePicture2",
      ),
    ];
  }
  // Future<List<ContactDataModel>> getAllContacts() async {
  //   final map = await DbHelper.getData(TblContactsConfigration.tblName);
  //   return map
  //       .map((e) => ContactDataModel(
  //             id: e[TblContactsConfigration.id],
  //             name: e[TblContactsConfigration.name],
  //             mobileNumber: e[TblContactsConfigration.mobileNumber],
  //             landlineNumber: e[TblContactsConfigration.landlineNumber],
  //             profilePicture: e[TblContactsConfigration.profilePicture],
  //           ))
  //       .toList();
  // }

  // Future<ContactDataModel> getContactById(int id) async {

  // }

  // Future<bool> AddContact(ContactDataModel contactDataModel) async{

  // }
  // Future<bool> DeleteContact(int id) async{

  // }
  // Future<bool> EditContact(ContactDataModel contactDataModel) async{

  // }
}
