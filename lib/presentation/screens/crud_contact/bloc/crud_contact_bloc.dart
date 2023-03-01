import 'package:bloc/bloc.dart';
import 'package:contact_app_bloc_architecture/common/di/get_it.dart';
import 'package:contact_app_bloc_architecture/data/service/contact_repository_service.dart';
import 'package:equatable/equatable.dart';

import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

part 'crud_contact_event.dart';
part 'crud_contact_state.dart';

class CRUDContactBloc extends Bloc<CRUDContactEvent, CRUDContactState> {
  // late ContactRepositoryService _contactRepositoryService;

// constructor
  CRUDContactBloc() : super(CRUDContactInitialState()) {
    // _contactRepositoryService = ContactRepositoryService.getInstance();
    on<CreateContactEvent>(_createContact);
    on<UpdateContactEvent>(_updateContact);
    on<DeleteContactEvent>(_deleteContact);
    on<ToggleFavoriteContactEvent>(_toggleFavorite);
  }

  ContactRepositoryService _getContactRepositoryService() {
    return locator.get<ContactRepositoryService>();
  }

  // bind events with states
  void _createContact(CreateContactEvent createUserEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    // await _contactRepositoryService
    await _getContactRepositoryService()
        .addContact(createUserEvent.contactDataModel)
        .then((value) => {
              emit(CreateCompletedState(value)),
            });
  }

  void _updateContact(UpdateContactEvent updateUserEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    // await _contactRepositoryService
    await _getContactRepositoryService()
        .editContact(updateUserEvent.contactDataModel)
        .then((value) => emit(UpdateCompletedState(value)));
  }

  void _toggleFavorite(ToggleFavoriteContactEvent toggleFavoriteContactEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    final newValue =
        toggleFavoriteContactEvent.contactDataModel.isFavorite ? 0 : 1;
    // await _contactRepositoryService
    await _getContactRepositoryService()
        .toggleFavorite(toggleFavoriteContactEvent.contactDataModel, newValue)
        .then((value) => emit(ToggleFavoriteContactCompletedState(value)));
  }

  void _deleteContact(DeleteContactEvent deleteContactEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    // await _contactRepositoryService
    await _getContactRepositoryService()
        .deleteContact(deleteContactEvent.contactDataModel)
        .then((value) => emit(DeleteCompletedState(value)));
  }
}
