import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

abstract class ContactRepository {
  Future<List<ContactDataModel>> getAllContacts(
      {String? where, List<Object>? whereArgs});

  Future<List<ContactDataModel>> getFavoriteContacts();

  Future<int> addContact(ContactDataModel contactDataModel);

  Future<int> editContact(ContactDataModel contactDataModel);

  Future<int> toggleFavorite(
      ContactDataModel contactDataModel, int newToggleValue);

  Future<int> deleteContact(ContactDataModel contactDataModel);
}
