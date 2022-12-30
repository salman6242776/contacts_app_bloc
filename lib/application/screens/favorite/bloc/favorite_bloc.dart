import 'package:bloc/bloc.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/domain/service/contact_repository_service.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  late ContactRepositoryService _contactRepositoryService;
  FavoriteBloc() : super(FavoriteInitial()) {
    _contactRepositoryService = ContactRepositoryService.getInstance();
    on<FetchFavoriteEvent>(_fetchFavorites);
  }

  void _fetchFavorites(FetchFavoriteEvent fetchFavoriteEvent,
      Emitter<FavoriteState> emit) async {
    emit(FetchFavoriteStarted());
    await _contactRepositoryService
        .getFavoriteContacts()
        .then((value) => emit(FetchFavoriteCompleted(value)));
  }
}
