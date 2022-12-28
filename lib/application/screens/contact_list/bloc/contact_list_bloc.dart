import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/domain/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_list_event.dart';
// part 'contact_list_state.dart';

// Block requires the events and states, in contact list screen event is to load the list and the state is list of Data
class ContactListBloc extends Bloc<ContactListEvent, List<ContactDataModel>> {
  late Repository _repository;

// must to provide inital state in super, as inital state of list is empty, so thats why passing empty list to the super method.
  ContactListBloc() : super([]) {
    _repository = Repository();

    on<ContactListFetchCompletedEvent>(_fetchAllContacts);
  }

  Future<void> _fetchAllContacts(ContactListFetchCompletedEvent event,
      Emitter<List<ContactDataModel>> emit) async {
    // emit(_repository.getAllContacts());
    final list = await _repository.getAllContacts();
    emit(list);
  }
}
