import 'dart:async';
import 'dart:math';
import 'package:checkout/modules/home/data/place_model.dart';
import 'package:checkout/services/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:checkout/modules/home/data/place_respositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  Random random = new Random();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    yield HomeInitial();
      await Future<void>.delayed(Duration(milliseconds: random.nextInt(600)));
      if (event is HomeTriggerEvent){
        final data = await DataCall().load(PlaceRepository.getPlaces());
        yield HomeAddDeleteState(
            items: data,
            action: "none"
        );
      } else if (event is HomeAddEvent){
        final data = await DataCall().load(PlaceRepository.addPlaces(event.name));
        yield HomeAddDeleteState(
          items: data, action: "Item added successfully!!!"
        );
      } else if (event is HomeDeleteEvent) {
        final data = await DataCall().load(PlaceRepository.deletePlaces(event.index));
        yield HomeAddDeleteState(
          items: data,
          action: "Item deleted successfully!!!"
        );
      } else if (event is HomeRefreshEvent) {
        final data = await DataCall().load(PlaceRepository.getPlaces());
        yield HomeAddDeleteState(
            items: data,
            action: "none"
        );
      }
  }
}
