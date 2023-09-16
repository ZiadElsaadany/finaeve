import 'package:equatable/equatable.dart';

class ListResponseModel extends Equatable {
  final List<BaseIdNameModel>? albumTypesOrder;
  final List<BaseIdNameModel>? painting;
  final List<AlbumSize>? albumSizes;
  final List<BaseIdNameModel>? yesOrNoOptions;
  final List<Extension>? extensions;
  final List<BaseIdNameModel>? pages;
  final List<Album>? albumTypes;
  final List<CoverType>? coverTypes;
  final List<Corner>? corners;
  final List<DrillingType>? drillingTypes;
  final List<SideImageSize>? sideImageSizes;
  final List<BaseIdNameModel>? imageTypes;
  final List<PaperType>? paperTypes;
  final List<BaseIdNameModel>? accessoriesTypes;
  final List<BoardSize>? boardSizes;
  final List<PrintSize>? printSizes;
  final List<ModelImage>? modelImages;
  final List<ColorResp>? colorResponse;
  const ListResponseModel({
    required this.albumTypesOrder,
    required this.albumSizes,
    required this.yesOrNoOptions,
    required this.extensions,
    required this.pages,
    required this.albumTypes,
    required this.coverTypes,
    required this.corners,
    required this.drillingTypes,
    required this.sideImageSizes,
    required this.imageTypes,
    required this.paperTypes,
    required this.accessoriesTypes,
    required this.boardSizes,
    required this.printSizes,
    required this.modelImages,
    required this.colorResponse,
    required this.painting
  });

  factory ListResponseModel.fromJson(Map<String, dynamic> json) =>
      ListResponseModel(
        painting:(json['painting'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList() ,
        albumTypesOrder: (json['albumType'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList(),
        albumSizes: List<AlbumSize>.from((json['AlbumSize'] as List)
            .map((albumSize) => AlbumSize.fromJson(albumSize))),
        yesOrNoOptions: (json['YesNo'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList(),
        extensions: List<Extension>.from(
            (json['Extension'] as List).map((e) => Extension.fromJson(e))),
        pages: (json['page'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList(),
        albumTypes: List<Album>.from(
            (json['AlbumTypelist'] as List).map((e) => Album.fromJson(e))),
        coverTypes: List<CoverType>.from(
            (json['CoverType'] as List).map((e) => CoverType.fromJson(e))),
        corners:
            List<Corner>.from((json['Corner'] as List).map((e) => Corner.fromJson(e))),
        drillingTypes: List<DrillingType>.from(
            (json['DrillingType'] as List).map((e) => DrillingType.fromJson(e))),
        sideImageSizes: List<SideImageSize>.from(
            (json['SideImageSize'] as List).map((e) => SideImageSize.fromJson(e))),
        imageTypes: (json['IamgeType'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList(),
        paperTypes: List<PaperType>.from(
            (json['PaperType'] as List).map((E) => PaperType.fromJson(E))),
        accessoriesTypes: (json['AccessoriesType'] as Map<String, dynamic>)
            .entries
            .map((e) => BaseIdNameModel(e.key.toString(), e.value.toString()))
            .toList(),
        boardSizes: List<BoardSize>.from(
            ( json['BoardSize'] as List).map((e) => BoardSize.fromJson(e))),
        printSizes: List<PrintSize>.from(
            (json['PrintSize'] as List).map((e) => PrintSize.fromJson(e))),
        modelImages: List<ModelImage>.from(
            json['ModelImage'].map((e) => ModelImage.fromJson(e))),
        colorResponse: List<ColorResp>.from(json["Color"].map((e)=>ColorResp.fromJson(e)))
      );

  @override
  List<Object?> get props => [
        albumTypesOrder,
        albumSizes,
        albumTypes,
        yesOrNoOptions,
        extensions,
        pages,
        coverTypes,
        corners,
        drillingTypes,
        sideImageSizes,
        imageTypes,
        paperTypes,
        accessoriesTypes,
        boardSizes,
        printSizes,
        modelImages,
    painting
      ];
}

class ModelImage {
  /*
   {
                "id": 30,
                "name": "البوم اكرلك طولي",
                "price": 100,
                "price2": 50,
                "mini": 1,
                "image": "https://www.eve-albums.com/uploads/album/16629937005387814.jpeg"
            },

   */

  final int id;
  final String name;
  final int price;
  final int price2;
  final int mini;
  final String imageUrl;

  ModelImage({
    required this.id,
    required this.name,
    required this.price,
    required this.price2,
    required this.mini,
    required this.imageUrl,
  });

  factory ModelImage.fromJson(Map<String, dynamic> json) => ModelImage(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        price2: json['price2'],
        mini: json['mini'],
        imageUrl: json['image'],
      );
}

class PrintSize extends BoardSize {
  PrintSize(
      {required int id,
      required String name,
      required String nameEng,
      required int status,
      required int price})
      : super(
            id: id, name: name, nameEng: nameEng, status: status, price: price);

  factory PrintSize.fromJson(Map<String, dynamic> json) => PrintSize(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
        price: json['price'],
      );
}

class BoardSize extends BaseInfo {
  final int price;

  BoardSize(
      {required int id,
      required String name,
      required String nameEng,
      required int status,
      required this.price})
      : super(
          id: id,
          name: name,
          nameEng: nameEng,
          status: status,
        );

  factory BoardSize.fromJson(Map<String, dynamic> json) => BoardSize(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
        price: json['price'],
      );
}

// class AccessoriesType extends BaseIdNameModel {
//   AccessoriesType(String id, String name) : super(id, name);
//
// }

class PaperType extends BaseInfo {
  PaperType(
      {required int id,
      required String name,
      required String nameEng,
      required int status})
      : super(id: id, name: name, nameEng: nameEng, status: status);

  factory PaperType.fromJson(Map<String, dynamic> json) => PaperType(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}

// class ImageType {
//   final String id;
//   final String name;
//
//   ImageType(this.id, this.name);
// }

class SideImageSize extends DrillingType {
  SideImageSize(
      {required int id,
      required String name,
      required String nameEng,
      required int price,
      required int price2,
      required int price3,
      required int status})
      : super(
          id: id,
          name: name,
          nameEng: nameEng,
          price: price,
          price2: price2,
          price3: price3,
          status: status,
        );

  factory SideImageSize.fromJson(Map<String, dynamic> json) => SideImageSize(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        price: json['price'],
        price2: json['price2'],
        price3: json['price3'],
        status: json['status'],
      );
}

class DrillingType {
  /*
   {
                "id": 15,
                "name": "بدون",
                "name_en": "Null",
                "price": 0,
                "price2": 0,
                "price3": 0,
                "status": 1
            },
   */

  final int id;
  final String name;
  final String nameEng;
  final int price;
  final int price2;
  final int price3;
  final int status;

  DrillingType({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.price,
    required this.price2,
    required this.price3,
    required this.status,
  });

  factory DrillingType.fromJson(Map<String, dynamic> json) => DrillingType(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        price: json['price'],
        price2: json['price2'],
        price3: json['price3'],
        status: json['status'],
      );
}

class Corner extends BaseInfo {
  Corner({
    required int id,
    required String name,
    required String nameEng,
    required int status,
  }) : super(id: id, name: name, nameEng: nameEng, status: status);

  factory Corner.fromJson(Map<String, dynamic> json) => Corner(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}

class CoverType {
  /*
   {
                "id": 2,
                "name": "ترتر/Shinning Star",
                "name_en": "ترتر/Shinning Star",
                "status": 1
            },
   */

  final int id;
  final String name;
  final String nameEng;
  final int status;

  CoverType({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.status,
  });

  factory CoverType.fromJson(Map<String, dynamic> json) => CoverType(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}
  class ColorResp {
  /*
   {
                "id": 2,
                "name": "ترتر/Shinning Star",
                "name_en": "ترتر/Shinning Star",
                "status": 1
            },
   */

  final int id;
  final String name;
  final String nameEng;
  final int status;

  ColorResp({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.status,
  });

  factory ColorResp.fromJson(Map<String, dynamic> json) => ColorResp(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}

class Album {
  /*
  {
                "id": 5,
                "name": "جلد يوتا ( خامه ايطالي)",
                "name_en": "YUTA",
                "price": 100,
                "price2": 100,
                "price3": 0,
                "status": 1

  },

   */
  final int id;
  final String name;
  final String nameEng;
  final int price1;
  final int price2;
  final int price3;
  final int status;

  Album({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.status,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        price1: json['price'],
        price2: json['price2'],
        price3: json['price3'],
        status: json['status'],
      );
}

// class PageResponse extends BaseIdNameModel{
//   PageResponse(String id, String name) : super(id, name);
// }

class Extension {
  /*
   {
                "id": 4,
                "name": "ميني البوم",
                "name_en": "mini Album ",
                "status": 1
            },
   */

  final int id;
  final String name;
  final String nameEng;
  final int status;

  Extension({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.status,
  });

  factory Extension.fromJson(Map<String, dynamic> json) => Extension(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}

// class YesOrNoOptions extends BaseIdNameModel {
//   YesOrNoOptions(String id, String name) : super(id, name);
// }

class BaseIdNameModel {
  final String id;
  final String name;

  BaseIdNameModel(this.id, this.name);
}

class AlbumSize extends BaseInfo {
  AlbumSize(
      {required int id,
      required String name,
      required String nameEng,
      required int status})
      : super(id: id, name: name, nameEng: nameEng, status: status);

  factory AlbumSize.fromJson(Map<String, dynamic> json) => AlbumSize(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );

/*
  {
                "id": 11,
                "name": "38X25",
                "name_en": "38X25",
                "price_10_page": 350,
                "status": 1,
            },
   */
}

// class AlbumTypeOrder {
//   final String id;
//   final String typeName;
//
//   AlbumTypeOrder({
//     required this.id,
//     required this.typeName,
//   });
// }

class BaseInfo {
  /*
   {
                "id": 2,
                "name": "ترتر/Shinning Star",
                "name_en": "ترتر/Shinning Star",
                "status": 1
            },
   */

  final int id;
  final String name;
  final String nameEng;
  final int status;

  BaseInfo({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.status,
  });

  factory BaseInfo.fromJson(Map<String, dynamic> json) => BaseInfo(
        id: json['id'],
        name: json['name'],
        nameEng: json['name_en'],
        status: json['status'],
      );
}
