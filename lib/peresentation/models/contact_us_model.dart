
import 'package:equatable/equatable.dart';

class ContactUsInformationModel  extends Equatable {



  final int id ;
  final  String whatssApp;
  final  String mobile;
  final  String address;
  final  String addressEn;
  final  String email;

  const ContactUsInformationModel(
  {
    required this.id,
    required this.mobile,
    required this.email,
    required this.address,
    required this.whatssApp,
    required this.addressEn
}
      );


  factory  ContactUsInformationModel.fromJson(
      Map<String,dynamic> json
      ) {
    return ContactUsInformationModel(
        id: json["id"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        addressEn: json["address_en"],
        whatssApp: json["whatsap"]);
  }

  @override
  List<Object?> get props => [

    id ,
     whatssApp,
     mobile,
     address,
     addressEn,
     email
  ];



}