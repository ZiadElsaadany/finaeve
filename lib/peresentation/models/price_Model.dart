import 'package:equatable/equatable.dart';

class PriceModel extends Equatable {
  final int price;
  final int status;

  const PriceModel({required this.price, required this.status});
  factory PriceModel.fromjson(Map<String, dynamic> json) =>
      PriceModel(price: json["data"], status: json["status"]);

  @override
  List<Object?> get props => [price, status];
}
