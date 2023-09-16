class ShowRequestModel {
  final int id;
  final String? album_type;
  final String? couple_name;
  final String? size;
  final String? paper_type;
  final String? cover_type;
  final String? extension_type;
  final String? color;
  final String? corner;
  final String? processing_type;
  final int? number_of_page;
  final String? drilling_type;
  final String? date;
  final String? hijri_date;
  final String? image_type;
  final String? image;
  final int? album_price;
  final String? url;
  final String? description;
  final String? other_color;
  final String? with_open_flash;
  final String? accessories_type;
  final String? side_image;
  final String? album_type2;
  final String? accessories_type_board;
  final String? accessories_type_print;
  final String? box;
  final int? number;
  final String? processing_note;
  final String? status;
  final String? created_at;
  final List<AlbumImage>? albumImages;

  ShowRequestModel(
      {required this.id,
      required this.album_type,
      required this.couple_name,
      required this.size,
      required this.paper_type,
      required this.cover_type,
      required this.extension_type,
      required this.color,
      required this.corner,
      required this.processing_type,
      required this.number_of_page,
      required this.drilling_type,
      required this.date,
      required this.hijri_date,
      required this.image_type,
      required this.image,
      required this.album_price,
      required this.url,
      required this.description,
      required this.other_color,
      required this.with_open_flash,
      required this.accessories_type,
      required this.side_image,
      required this.album_type2,
      required this.accessories_type_board,
      required this.accessories_type_print,
      required this.box,
      required this.number,
      required this.processing_note,
      required this.status,
      required this.created_at,
      required this.albumImages});
  factory ShowRequestModel.fromJson(Map<String, dynamic> json) {
    return ShowRequestModel(
        id: json["id"],
        album_type: json["album_type"] ?? "",
        couple_name: json["couple_name"] ?? "",
        size: json["size"] ?? "",
        paper_type: json["paper_type"] ?? "",
        cover_type: json["cover_type"] ?? "",
        extension_type: json["extension_type"] ?? "",
        color: json["color"] ?? "",
        corner: json["corner"] ?? "",
        processing_type: json["processing_type"] ?? "",
        number_of_page: json["number_of_page"] ?? 0,
        drilling_type: json["drilling_type"] ?? "",
        date: json["date"] ?? "",
        hijri_date: json["hijri_date"] ?? "",
        image_type: json["image_type"] ?? "",
        image: json["image"] ?? "",
        album_price: json["album_price"] ?? 0,
        url: json["url"] ?? "",
        description: json["description"] ?? "",
        other_color: json["other_color"] ?? "",
        with_open_flash: json["with_open_flash"] ?? "",
        accessories_type: json["accessories_type"] ?? "",
        side_image: json["side_image"] ?? "",
        album_type2: json["album_type2"] ?? "",
        accessories_type_board: json["accessories_type_board"] ?? "",
        accessories_type_print: json["accessories_type_print"] ?? "",
        box: json["box"] ?? "",
        number: json["number"] ?? 0,
        processing_note: json["processing_note"] ?? "",
        status: json["status"] ?? "",
        created_at: json["created_at"] ?? "",
        albumImages: List<AlbumImage>.from((json["AlbumImages"] ?? List)
                .map((e) => AlbumImage.fromJson(e))) ??
            []);
  }

  // "id": 8909,
  // "album_type": "طلب البوم مع الطباعه",
  // "couple_name": "name",
  // "size": "70X27",
  // "paper_type": "مطفي/Matte",
  // "cover_type": "",
  // "extension_type": "بوكس",
  // "color": "ابيض/White",
  // "corner": "فضي/Silver",
  // "processing_type": "",
  // "number_of_page": 1,
  // "drilling_type": "مزخرف",
  // "date": "2023-06-06 00:00:00",
  // "hijri_date": "",
  // "image_type": "Info@eve-albums.com",
  // "image": "https://www.eve-albums.com/uploads/avatar/avatar.png",
  // "url": "",
  // "description": "",
  // "album_price": 30,
  // "other_color": "",
  // "with_open_flash": "نعم",
  // "accessories_type": "لم يحدد",
  // "accessories_type_board": "لم يحدد",
  // "accessories_type_print": "لم يحدد",
  // "side_image": "نعم",
  // "box": "نعم",
  // "album_type2": "مخمل/Velvet",
  // "number": 4,
  // "processing_note": "",
  // "created_at": "2023-06-20 23:33:40",
  // "status": "غير محدد",
  // "AlbumImages": [
  // {
  // "id": 6,
  // "image": "https://www.eve-albums.com/uploads/album/168729507847181451.png"
  // },
  // ]
}

class AlbumImage {
  final int id;
  final String image;
  AlbumImage({required this.id, required this.image});
  factory AlbumImage.fromJson(Map<String, dynamic> json) {
    return AlbumImage(image: json["image"], id: json["id"]);
  }
}
