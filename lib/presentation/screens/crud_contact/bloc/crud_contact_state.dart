part of 'crud_contact_bloc.dart';

abstract class CRUDContactState extends Equatable {
  const CRUDContactState();

  @override
  List<Object> get props => [];
}

class CRUDContactInitialState extends CRUDContactState {}

class ShowLoaderState extends CRUDContactState {}

class DeleteCompletedState extends CRUDContactState {
  final int isSuccessful;
  const DeleteCompletedState(this.isSuccessful);
}

class UpdateCompletedState extends CRUDContactState {
  final int isSuccessful;
  const UpdateCompletedState(this.isSuccessful);
}

class CreateCompletedState extends CRUDContactState {
  final int isSuccessful;
  const CreateCompletedState(this.isSuccessful);
}

class ToggleFavoriteContactCompletedState extends CRUDContactState {
  final int isSuccessful;
  const ToggleFavoriteContactCompletedState(this.isSuccessful);
}
