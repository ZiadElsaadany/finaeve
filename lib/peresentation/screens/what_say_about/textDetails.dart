
import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';

class TextSayDetailsScreen extends StatelessWidget {
  const TextSayDetailsScreen({Key? key, required this.title, required this.name, required this.position}) : super(key: key);

  final String title;
  final String name  ;
  final String position ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Text(tr(StringConstants.whatSay) , style:const TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 20
              ), textAlign: TextAlign.center,),
              const SizedBox(height: 15,),
              Text(title
,
              textAlign: TextAlign.center
              ,style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.myBlack
                ),
              ),
              Text(name ,
                  textAlign: TextAlign.center

                  ,style: const TextStyle(
                  color: MyColors.primaryColor ,
                  fontSize: 16
                ),
              ),

              Text(position ,
                  textAlign: TextAlign.center
,
                  style: const TextStyle(
                  color: MyColors.primaryColor ,
                    fontSize: 16
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
