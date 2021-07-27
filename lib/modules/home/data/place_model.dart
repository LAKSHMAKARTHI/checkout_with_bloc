import 'package:equatable/equatable.dart';

class PlaceItemModel extends Equatable{
  final List<PlaceModel> item;

  const PlaceItemModel({this.item = const <PlaceModel>[]});

  factory PlaceItemModel.fromJson(List<dynamic> json){
    return PlaceItemModel(
      item: json.map((i) => PlaceModel(i['name'], i['data'])).toList()
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [item];
}

class PlaceModel extends Equatable{
  final String name;
  final List data;

  PlaceModel(this.name, this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [name, data];
}