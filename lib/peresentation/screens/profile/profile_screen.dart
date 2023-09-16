import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/profile/information_profile_screen.dart';
import '/peresentation/screens/profile/password_screen.dart';
import '/utilities/constants/images.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utilities/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(tr(StringConstants.profile),
            style: const TextStyle(
                color: MyColors.primaryColor,
                fontSize: 20
            ),
          ),
          Image.asset(ImageConstants.rectangleDesign,
            width: 23,
            height: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xffC5C5C5)
              )
            ),
            child: ListTile(
              onTap:  ( )  {
                Navigator.pushNamed(context, InformationProfileScreen.id);
              } ,
              title:  Text(tr(StringConstants.profileInfo),
              style: const TextStyle(
                color: MyColors.primaryColor,
                fontSize: 16
              ),
              ),
              leading: SvgPicture.asset(PhotosConstants.loginIconDrawer),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: const Color(0xffC5C5C5)
                )
            ),
            child:  ListTile(
              onTap:  ( ) {
                Navigator.pushNamed(context, PasswordScreen.id);
              },
              leading:const Icon(Icons.lock) ,
              title:  Text(tr(StringConstants.pass),
              style: const TextStyle(
                  color: MyColors.primaryColor,
    fontSize: 16

              ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

