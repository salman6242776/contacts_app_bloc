import 'package:bloc/bloc.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/domain/repository.dart';
import 'package:equatable/equatable.dart';

part 'add_edit_contact_event.dart';
part 'add_edit_contact_state.dart';

class AddEditContactBloc
    extends Bloc<AddEditContactEvent, AddEditContactState> {
  late Repository _repository;

// constructor
  AddEditContactBloc() : super(AddEditContactInitialState()) {
    _repository = Repository();
    on<CreateUserEvent>(createUser);
  }

  // bind events with states
  void createUser(CreateUserEvent createUserEvent,
      Emitter<AddEditContactState> emit) async {
    emit(ShowLoaderState());
    await _repository
        .addContact(createUserEvent.contactDataModel)
        .then((value) => {
              emit(CreateCompletedState(value)),
            });
  }
}
