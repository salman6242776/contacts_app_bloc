part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FetchFavoriteStarted extends FavoriteState {}

class FetchFavoriteCompleted extends FavoriteState {
  List<ContactDataModel> list;
  FetchFavoriteCompleted(this.list);

  @override
  // TODO: implement props
  List<Object> get props => list;
}
