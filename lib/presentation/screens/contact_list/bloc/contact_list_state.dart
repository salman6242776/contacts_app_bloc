part of 'contact_list_bloc.dart';

abstract class ContactListState {}

class ContactListStateInitial extends ContactListState {}

class ContactListStateFetchStarted extends ContactListState {}

class ContactListStateFetchCompletedSuccessfully extends ContactListState {
  List<ContactDataModel> contactDataModelList;

  ContactListStateFetchCompletedSuccessfully(this.contactDataModelList);
}

class ContactListStateFetchCompletedWithError extends ContactListState {
  String errorMessage;
  ContactListStateFetchCompletedWithError(this.errorMessage);
}
