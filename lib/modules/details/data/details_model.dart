import 'package:equatable/equatable.dart';

class DetailsItemsModel extends Equatable{
  final List<DetailsModel> item;

  const DetailsItemsModel({this.item = const <DetailsModel>[]});

  factory DetailsItemsModel.fromJson(List<dynamic> json){
    return DetailsItemsModel(
      item: json.map((i) => DetailsModel(i['title'], i['status'])).toList()
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [item];
}

class DetailsModel extends Equatable{
  final String title;
  final bool status;

  DetailsModel(this.title, this.status);

  @override
  // TODO: implement props
  List<Object?> get props => [title, status];
}