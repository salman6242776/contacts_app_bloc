part of 'contact_list_bloc.dart';

abstract class ContactListEvent {}

// class ContactListFetchStartedEvent extends ContactListEvent {
//   ContactListFetchStartedEvent();
// }

class ContactListFetchCompletedEvent extends ContactListEvent {
  final List<ContactDataModel> contactDataModelList;

  ContactListFetchCompletedEvent({required this.contactDataModelList});
}
