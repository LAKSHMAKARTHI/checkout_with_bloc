part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeAddDeleteState extends HomeState {
  final PlaceItemModel items;
  final String action;

  const HomeAddDeleteState({this.items = const PlaceItemModel(), required this.action});

  @override
  List<Object> get props => [items, action];
}

class HomeErrorState extends HomeState {
  @override
  List<Object> get props => [];
}
