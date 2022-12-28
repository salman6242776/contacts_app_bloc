part of 'add_edit_contact_bloc.dart';

abstract class AddEditContactState extends Equatable {
  const AddEditContactState();

  @override
  List<Object> get props => [];
}

class AddEditContactInitialState extends AddEditContactState {}

class ShowLoaderState extends AddEditContactState {}

class DeleteCompletedState extends AddEditContactState {}

class UpdateCompletedState extends AddEditContactState {}

class CreateCompletedState extends AddEditContactState {
  final int isSuccessful;
  const CreateCompletedState(this.isSuccessful);
}
