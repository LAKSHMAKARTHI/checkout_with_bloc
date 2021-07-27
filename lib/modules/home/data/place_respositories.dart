import 'dart:convert';
import 'package:checkout/modules/home/data/place_model.dart';
import 'package:checkout/services/data_provider.dart';

class PlaceRepository{
  static DataProvider<PlaceItemModel> getPlaces(){
    return DataProvider(
        isHome: true,
        type: 'get',
        selectedindex: 0,
        res: (response){
          final res = PlaceItemModel.fromJson(json.decode(response));
          return res;
        }
    );
  }

  static DataProvider<PlaceItemModel> refreshPlaces(){
    return DataProvider(
        isHome: true,
        type: 'refresh',
        selectedindex: 0,
        res: (response){
          final res = PlaceItemModel.fromJson(json.decode(response));
          return res;
        }
    );
  }

  static DataProvider<PlaceItemModel> addPlaces(name){
    return DataProvider(
        isHome: true,
        text: name,
        type: 'add',
        selectedindex: 0,
        res: (response){
          final res = PlaceItemModel.fromJson(json.decode(response));
          return res;
        }
    );
  }

  static DataProvider<PlaceItemModel> deletePlaces(index){
    return DataProvider(
        isHome: true,
        index: index,
        type: 'delete',
        selectedindex: 0,
        res: (response){
          final res = PlaceItemModel.fromJson(json.decode(response));
          return res;
        }
    );
  }

  static DataProvider<PlaceItemModel> intentPlaces(index){
    return DataProvider(
        isHome: true,
        index: index,
        type: 'intent',
        selectedindex: index,
        res: (response){
          final res = PlaceItemModel.fromJson(json.decode(response));
          return res;
        }
    );
  }
}