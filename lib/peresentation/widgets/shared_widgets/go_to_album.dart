import 'package:easy_localization/easy_localization.dart';
import '/peresentation/album/album_specifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../screens/auth/login.dart';

class RequestAlbumImage extends StatelessWidget {
  const RequestAlbumImage(
      {Key? key,
        this.txt = StringConstants.orderAlbumNow,  this.imageOrNot=true
      }) : super(key: key);
final String   txt ;
final bool imageOrNot;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       if(token==null) {
         Navigator.push(
             context,MaterialPageRoute(builder: (ctx)  {
               return LoginPage();
         } ));
       }else{
         Navigator.push(
             context,
             PageTransition(
                 child: const AlbumSpecificationScreen(),
                 duration: const Duration(milliseconds: 500),
                 reverseDuration: const Duration(milliseconds: 500),
                 type: PageTransitionType.bottomToTop));
       }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(ImageConstants.pointsBorder),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
         imageOrNot?     SvgPicture.asset(PhotosConstants.navAlbumSelected):SizedBox(),
              const SizedBox(
                width: 8,
              ),
              Text(
                tr(txt),
                style:
                    const TextStyle(fontSize: 14, color: MyColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
