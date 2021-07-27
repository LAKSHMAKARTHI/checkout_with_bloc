part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashTriggerState extends SplashState{
  final bool isLoadingFinish;

  const SplashTriggerState(this.isLoadingFinish);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoadingFinish];
}

class SplashErrorState extends SplashState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
