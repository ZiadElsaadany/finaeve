import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class PartyDrawingTemplate extends StatelessWidget {
  const PartyDrawingTemplate({Key? key, required this.image, required this.txt}) : super(key: key);
  final String image;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Container(
            // padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0001,),
              height:
              MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              color: MyColors.myYellow,
              child: Image.asset(image)),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Container(
            // padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0001,),
              height:
              MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              color: MyColors.primaryColor,
              child:  Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
