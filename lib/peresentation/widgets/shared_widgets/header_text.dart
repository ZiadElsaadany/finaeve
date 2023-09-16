import 'dart:ui';

import '/utilities/constants/images.dart';
import 'package:flutter/material.dart';
import '../../../utilities/constants/colors.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
            fontSize: 32,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.006,
        ),
        Image.asset(
          ImageConstants.rectangleDesign,

          alignment: AlignmentDirectional.topCenter,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        )
      ],
    );
  }
}
