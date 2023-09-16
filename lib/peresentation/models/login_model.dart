

import 'package:equatable/equatable.dart';

class LoginModel  extends Equatable{


  final String name;
  final String username;
  final int userId;
  final String email;
  final String mobile;
  final String description;

  final String country;

  final String city;
  final String region;
  final String createdAt;
  final String deviceToken;
  final String deviceType;
  final int userType;
  final int activate;
  final String avatar;

  const LoginModel({
required this.name,required this.email,
    required this.description,
    required this.userId,
    required this.activate,
    required this.avatar,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.deviceToken,
    required this.deviceType,
    required this.mobile,
    required this.region,
    required this.username,
    required this.userType
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
       description: json["description"],
       name: json["name"],
       activate:json["activate"] ,
      avatar:json["avatar"] ,
      city: json["city"],
       country:json["country"] ,
       createdAt: json["description"],
      deviceToken: json["device_token"],
      deviceType: json["device_type"],
      email: json["email"],
      mobile: json["mobile"],
        region: json["region"],
      userId: json["user_id"],
        username:json["username"],
      userType: json["user_type"],





    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[

  name,
  username,
  userId,
  email,
  mobile,
  description,

  country,

  city,
  region,
  createdAt,
  deviceToken,
  deviceType,
  userType,
  activate,
  avatar,
  ];


}
/**{
    "status": 1,
    "data": [
    {
    "status": 1,
    "access_token": "uVwqBrPOoO4dS8AmksxND9SUXM5cI_-W",
    "message": "Login has done successfully",
    "data": {
    "user_id": 3,
    "username": "alrajihi",
    "name": "alrajihi26",
    "email": "amr.alrajihi95@gmail.com",
    "mobile": "+2011473684385",
    "description": "",
    "country": "",
    "city": "",
    "region": "",
    "created_at": "2021-12-02",
    "device_token": "13",
    "device_type": "android",
    "user_type": 3,
    "status": 10,
    "activate": 1,
    "avatar": "https://www.eve-albums.com/uploads/avatar/16832120338904491.jpeg"
    }
    }
    ]
    }*/