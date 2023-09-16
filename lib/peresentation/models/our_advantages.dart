class OurAdvantagesModel {
  final int id;
  final String title;
  final String titleEn;
  final String? url;
  final String image;

  OurAdvantagesModel(
      {required this.id,
      required this.title,
      required this.titleEn,
      this.url,
      required this.image});


  factory OurAdvantagesModel.fromJson(Map<String, dynamic> map) {
    return OurAdvantagesModel(
      id: map['id'] ,
      title: map['title'] ,
      titleEn: map['title_en'],
      url: map['url'] as String,
      image: map['image'] as String,
    );
  }
}
