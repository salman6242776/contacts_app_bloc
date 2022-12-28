part of 'add_edit_contact_bloc.dart';

abstract class AddEditContactEvent extends Equatable {
  final ContactDataModel contactDataModel;
  const AddEditContactEvent(this.contactDataModel);

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AddEditContactEvent {
  const CreateUserEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}

class UpdateUserEvent extends AddEditContactEvent {
  const UpdateUserEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}

class DeleteUserEvent extends AddEditContactEvent {
  const DeleteUserEvent(ContactDataModel contactDataModel)
      : super(contactDataModel);
}
