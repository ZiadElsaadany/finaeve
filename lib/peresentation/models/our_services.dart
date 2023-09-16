class OurServicesModel {
  final int id;
  final String title;
  final String titleEn;
  final String text;
  final String textEn;
  final String image;

  OurServicesModel({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.text,
    required this.textEn,
    required this.image,
  });

  factory OurServicesModel.fromJson(Map<String, dynamic> json) {
    return OurServicesModel(
      id: json['id'],
      title: json['title'],
      titleEn: json['title_en'],
      text: json['text'],
      textEn: json['text_en'],
      image: json['image'],
    );
  }
}
