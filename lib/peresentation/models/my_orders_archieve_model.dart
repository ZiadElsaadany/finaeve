class MyOrdersArchive {
  final int id;
  final String albumType;
   String ? date;
   String ?status;
  final String image;
  final String ?created_at;

  MyOrdersArchive(
      {required this.id,
        required this.created_at,
      required this.albumType,
       this.date="",
      required this.status,
      required this.image});


  factory MyOrdersArchive.fromJson(Map<String, dynamic> json) {
    return MyOrdersArchive(
      id: json['id'],
      created_at: json["created_at"],
      albumType: json['image_type'],
      date: json['date'] ,
      status: json['status'] ,
      image: json['image'] ,
    );
  }
}
