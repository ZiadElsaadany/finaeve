import 'package:equatable/equatable.dart';

class ListsModel extends Equatable {
  final int id;
  final String name;
  final String nameEn;
  final int price10Page;
  final int status;
  final int priceExtraPage;
  final int priceBox;
  final int priceProcess;
  final int priceAccessories;
  final int print10Page2;
  final int priceExtraPage2;
  final int priceBox2;
  final int priceProcess2;
  final int priceAccessories2;
  final int pricePage3;
  final int priceExtraPage3;
  final int priceBox3;
  final int priceProcess3;
  final int priceAccessories3;

  const ListsModel(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.price10Page,
      required this.status,
      required this.priceExtraPage,
      required this.priceBox,
      required this.priceProcess,
      required this.priceAccessories,
      required this.print10Page2,
      required this.priceExtraPage2,
      required this.priceBox2,
      required this.priceProcess2,
      required this.priceAccessories2,
      required this.pricePage3,
      required this.priceExtraPage3,
      required this.priceBox3,
      required this.priceProcess3,
      required this.priceAccessories3});

  factory ListsModel.fromjson(Map<String, dynamic> json) => ListsModel(
      id: json["id"],
      name: json["name"],
      nameEn: json["name_en"],
      price10Page: json["price_10_page"],
      status: json["status"],
      priceExtraPage: json["price_extra_page"],
      priceBox: json["price_box"],
      priceProcess: json["price_process"],
      priceAccessories: json["price_accessories"],
      print10Page2: json["price_10_page2"],
      priceExtraPage2: json["price_extra_page2"],
      priceBox2: json["price_box2"],
      priceProcess2: json["price_process2"],
      priceAccessories2: json["price_accessories2"],
      pricePage3: json["price_10_page3"],
      priceExtraPage3: json["price_extra_page3"],
      priceBox3: json["price_box3"],
      priceProcess3: json["price_process3"],
      priceAccessories3: json["price_accessories3"]);
  @override
  List<Object?> get props => [
        id,
        name,
        nameEn,
        price10Page,
        status,
        priceExtraPage,
        priceBox,
        priceProcess,
        priceAccessories,
        print10Page2,
        priceExtraPage2,
        priceBox2,
        priceProcess2,
        priceAccessories2,
        pricePage3,
        priceExtraPage3,
        priceBox3,
        priceProcess3,
        priceAccessories3
      ];
}
