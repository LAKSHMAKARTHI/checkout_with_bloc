part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class DetailsTriggerEvent extends DetailsEvent{
  final int pindex;
  DetailsTriggerEvent(this.pindex);

  @override
  // TODO: implement props
  List<Object?> get props => [pindex];
}

class DetailsResetEvent extends DetailsEvent{
  final int pindex;
  DetailsResetEvent(this.pindex);

  @override
  // TODO: implement props
  List<Object?> get props => [pindex];
}

class DetailsAddEvent extends DetailsEvent{
  final String title;
  final int pindex;
  DetailsAddEvent(this.title, this.pindex);
  @override
  // TODO: implement props
  List<Object?> get props => [title, pindex];
}

class DetailsDeleteEvent extends DetailsEvent{
  final int index;
  final int pindex;
  DetailsDeleteEvent(this.index, this.pindex);
  @override
  // TODO: implement props
  List<Object?> get props => [index, pindex];
}

class DetailsStatusEvent extends DetailsEvent{
  final int index;
  final int pindex;
  DetailsStatusEvent(this.index, this.pindex);
  @override
  // TODO: implement props
  List<Object?> get props => [index, pindex];
}