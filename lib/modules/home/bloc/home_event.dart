part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeTriggerEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeAddEvent extends HomeEvent{
  final String name;
  HomeAddEvent(this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class HomeDeleteEvent extends HomeEvent{
  final int index;
  HomeDeleteEvent(this.index);
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class HomeRefreshEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
