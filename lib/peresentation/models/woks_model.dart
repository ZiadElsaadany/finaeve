import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class WorksModel extends Equatable{
  // {
  // "id": 11,
  // "title": "-",
  // "title_en": "-",
  // "text": "<p>-</p>\r\n",
  // "text_en": "<p>-</p>\r\n",
  // "image": "https://www.eve-albums.com/uploads/product/16426797884253495.jpg",
  // "images": [
  // {
  // "id": 0,
  // "product_id": 0,
  // "image": "https://www.eve-albums.com/uploads/product/16426797884253495.jpg"
  // }
  // ],
  // "youtube_code": ""
  // },
  final int id ;
  final String title;
  final String titleEn;
  final String text;
  final String textEn;
  final String image ;
  final List<Images> images;
  final String youtubeCode;


 const  WorksModel(
      {
    required this.image ,
        required this.id,
        required this.text,
        required this.title,
        required this.images,
        required this.textEn,
        required this.titleEn,
        required this.youtubeCode
}
      ) ;
 factory  WorksModel.fromJson ( Map<String, dynamic> json )  {
   return WorksModel(image: json["image"],
       id: json["id"],
       text: json["text"],
       title: json["title"],
       images: List<Images>.from((json["images"] as List).map((e) => Images.fromJson(e))),
       textEn: json["text_en"],
       titleEn: json["title_en"],
       youtubeCode: json["youtube_code"]);
 }

  @override
  // TODO: implement props
  List<Object?> get props =>  [
    id ,
    title,
    titleEn,
    text,
    textEn,
    image ,
    images,
    youtubeCode
  ];
}


class Images extends Equatable{
  final int id;
  final int productId;
  final String image;
const   Images(
  {
    required  this.id,
    required this.image,
    required this.productId
}
      );

factory Images.fromJson( Map<String ,dynamic> json ) { 
  return Images(id: json["id"], image: json["image"], productId: json["product_id"]);
}

  @override
  List<Object?> get props =>[
    id,
    productId,
    image
  ];

}