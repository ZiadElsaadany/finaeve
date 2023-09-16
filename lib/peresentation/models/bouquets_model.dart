class BouquetsModel {
  final int id;
  final String name;
  final String nameEn;
  final String description;
  final String descriptionEn;
  final String image;
  final int price;

  BouquetsModel(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.description,
      required this.descriptionEn,
      required this.image,
      required this.price});

  factory BouquetsModel.fromJson(Map<String, dynamic> json) {
    return BouquetsModel(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'] ,
      description: json['description'] ,
      descriptionEn: json['description_en'] ,
      image: json['image'] ,
      price: json['price'] ,
    );
  }
}
