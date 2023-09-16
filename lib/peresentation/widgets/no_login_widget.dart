import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/auth/login.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/photos.dart';

class NoLoginWidget extends StatelessWidget {
  const NoLoginWidget({Key? key}) : super(key: key);


  static const id="No widget screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        title: SvgPicture.asset(
          PhotosConstants.eveLogo,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.09,
        ),
        actions: [SvgPicture.asset(
            PhotosConstants.world)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Lottie.asset("assets/lottie/no_login.json",
height:MediaQuery.of(context).size.height*0.5
),
            MaterialButton(onPressed: (){
              Navigator.pushNamed(context,  LoginPage.id);
            },
              color: MyColors.primaryColor,
            child:  Text( tr(StringConstants.login),
            style: const TextStyle(
              color: MyColors.myWhite
            ),),
            )
          ],
        ),
      ),
    );
  }
}
