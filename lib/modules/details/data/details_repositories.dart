import 'dart:convert';
import 'package:checkout/modules/details/data/details_model.dart';
import 'package:checkout/services/data_provider.dart';

class DetailsRepository{
  static DataProvider<DetailsItemsModel> getDetails(sindex){
    return DataProvider(
        isHome: false,
        type: 'get',
        selectedindex: sindex,
        res: (response){
          final res = DetailsItemsModel.fromJson(json.decode(response)[sindex]['data']);
          return res;
        }
    );
  }

  static DataProvider<String> getTitle(sindex){
    return DataProvider(
        isHome: false,
        type: 'title',
        selectedindex: sindex,
        res: (response){
          return response;
        }
    );
  }

  static DataProvider<DetailsItemsModel> addDetails(title, sindex){
    return DataProvider(
        isHome: false,
        type: 'add',
        text: title,
        selectedindex: sindex,
        res: (response){
          final res = DetailsItemsModel.fromJson(json.decode(response)[sindex]['data']);
          return res;
        }
    );
  }

  static DataProvider<DetailsItemsModel> deleteDetails(index, sindex){
    return DataProvider(
        isHome: false,
        type: 'delete',
        index: index,
        selectedindex: sindex,
        res: (response){
          final res = DetailsItemsModel.fromJson(json.decode(response)[sindex]['data']);
          return res;
        }
    );
  }

  static DataProvider<DetailsItemsModel> statusDetails(index, sindex){
    return DataProvider(
        isHome: false,
        type: 'status',
        index: index,
        selectedindex: sindex,
        res: (response){
          final res = DetailsItemsModel.fromJson(json.decode(response)[sindex]['data']);
          return res;
        }
    );
  }

  static DataProvider<DetailsItemsModel> resetDetails(sindex){
    return DataProvider(
        isHome: false,
        type: 'reset',
        selectedindex: sindex,
        res: (response){
          final res = DetailsItemsModel.fromJson(json.decode(response)[sindex]['data']);
          return res;
        }
    );
  }
}