import 'package:bloc/bloc.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/domain/repository.dart';
import 'package:equatable/equatable.dart';

part 'crud_contact_event.dart';
part 'crud_contact_state.dart';

class CRUDContactBloc extends Bloc<CRUDContactEvent, CRUDContactState> {
  late Repository _repository;

// constructor
  CRUDContactBloc() : super(CRUDContactInitialState()) {
    _repository = Repository();
    on<CreateContactEvent>(createContact);
    on<UpdateContactEvent>(updateContact);
  }

  // bind events with states
  void createContact(CreateContactEvent createUserEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    await _repository
        .addContact(createUserEvent.contactDataModel)
        .then((value) => {
              emit(CreateCompletedState(value)),
            });
  }

  void updateContact(UpdateContactEvent updateUserEvent,
      Emitter<CRUDContactState> emit) async {
    emit(ShowLoaderState());
    await _repository
        .editContact(updateUserEvent.contactDataModel)
        .then((value) => emit(UpdateCompletedState(value)));
  }
}
