import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:checkout/modules/details/data/details_model.dart';
import 'package:checkout/modules/details/data/details_repositories.dart';
import 'package:checkout/services/data_provider.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());
  Random random = new Random();
  
  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    yield DetailsInitial();
    await Future<void>.delayed(Duration(milliseconds: random.nextInt(500)));
    if (event is DetailsTriggerEvent){
      final data = await DataCall().load(DetailsRepository.getDetails(event.pindex));
      yield DetailsActionState(
        items: data, action: "none"
      );
    } else if (event is DetailsAddEvent){
      final data = await DataCall().load(DetailsRepository.addDetails(event.title, event.pindex));
      yield  DetailsActionState(
        items: data, action: "Item added successfully!!!"
      );
    } else if (event is DetailsDeleteEvent){
      final data = await DataCall().load(DetailsRepository.deleteDetails(event.index, event.pindex));
      yield  DetailsActionState(
          items: data, action: "Item deleted successfully!!!"
      );
    } else if (event is DetailsStatusEvent){
      final data = await DataCall().load(DetailsRepository.statusDetails(event.index, event.pindex));
      yield  DetailsActionState(
        items: data, action: "Status changed successfully!!!"
      );
    } else if (event is DetailsResetEvent){
      final data = await DataCall().load(DetailsRepository.resetDetails(event.pindex));
      yield  DetailsActionState(
          items: data, action: "Items reset successfully!!!"
      );
    }
  }
}
