import '/utilities/constants/colors.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.27,
      child: Container(

        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(
            bottom: 15,
            top:35,
            right: 25,
            left: 25,

        ),
        decoration:const BoxDecoration(
          color: MyColors.primaryColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10
          ),
          child: SvgPicture.asset(PhotosConstants.eveLogo),
        ),
      ),
    );
  }
}
