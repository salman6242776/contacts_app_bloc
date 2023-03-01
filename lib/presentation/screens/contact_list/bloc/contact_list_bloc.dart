import 'package:contact_app_bloc_architecture/common/di/get_it.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/data/service/contact_repository_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

// Block requires the events and states, in contact list screen event is to load the list and the state is list of Data
// class ContactListBloc extends Bloc<ContactListEvent, List<ContactDataModel>> {
class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  // late ContactRepositoryService _contactRepositoryService;

// must to provide inital state in super, as inital state of list is empty, so thats why passing empty list to the super method.
  ContactListBloc() : super(ContactListStateInitial()) {
    // _contactRepositoryService = ContactRepositoryService.getInstance();

    on<ContactListFetchCompletedEvent>(_fetchAllContacts);
  }

  Future<void> _fetchAllContacts(
      ContactListFetchCompletedEvent event,
      // Emitter<List<ContactDataModel>> emit) async {
      Emitter<ContactListState> emit) async {
    // emit(_repository.getAllContacts());
    emit(ContactListStateFetchStarted());
    try {
      // final list = await _contactRepositoryService.getAllContacts();
      final list =
          await locator.get<ContactRepositoryService>().getAllContacts();
      // if (list.isEmpty) {
      //   emit(ContactListStateFetchCompletedWithError("List is empty"));
      // } else {
      emit(ContactListStateFetchCompletedSuccessfully(list));
      // }
    } catch (ex) {
      emit(ContactListStateFetchCompletedWithError("Exception"));
    }
  }
}
