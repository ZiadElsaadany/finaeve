import 'package:equatable/equatable.dart';

class BoardPriceModel extends Equatable {
  final int price;

  const BoardPriceModel({required this.price});
  factory BoardPriceModel.fromjson(Map<String, dynamic> json) =>
      BoardPriceModel(price: json["data"]);
  @override
  List<Object?> get props => [price];
}
