part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  DetailsInitial();
  @override
  List<Object> get props => [];
}

class DetailsActionState extends DetailsState {
  final DetailsItemsModel items;
  final String action;
  const DetailsActionState({this.items = const DetailsItemsModel(), required this.action});
  @override
  List<Object> get props => [items, action];
}

class DetailsErrorState extends DetailsState {
  @override
  List<Object> get props => [];
}
