part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class SplashTriggerEvent extends SplashEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
