import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_edit_contact_event.dart';
part 'add_edit_contact_state.dart';

class AddEditContactBloc extends Bloc<AddEditContactEvent, AddEditContactState> {
  AddEditContactBloc() : super(AddEditContactInitial()) {
    on<AddEditContactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
