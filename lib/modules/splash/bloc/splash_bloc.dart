import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SplashTriggerEvent){
      try{
        await Future<void>.delayed(Duration(milliseconds: 1000));
        yield SplashTriggerState(true);
      } catch(_){
        yield SplashErrorState();
      }
    }
  }
}
