import '/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.text}) : super(key: key);
final String text ;
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/91868-empty.json",
        height: MediaQuery.of(context).size.height*0.3
        ),
        Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MyColors.primaryColor,
          fontSize: 16
        ),
        )
      ],
    );
  }
}
