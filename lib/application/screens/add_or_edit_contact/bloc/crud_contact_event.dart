part of 'crud_contact_bloc.dart';

abstract class CRUDContactEvent extends Equatable {
  final ContactDataModel contactDataModel;
  const CRUDContactEvent(this.contactDataModel);

  @override
  List<Object> get props => [];
}

class CreateContactEvent extends CRUDContactEvent {
  const CreateContactEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}

class UpdateContactEvent extends CRUDContactEvent {
  const UpdateContactEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}

class DeleteContactEvent extends CRUDContactEvent {
  const DeleteContactEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}
