import '/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key, required this.txt}) : super(key: key);
final String txt;
  @override
  Widget build(BuildContext context) {
    return         Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/45721-no-internet.json",
        height: MediaQuery.of(context).size.height*0.2
        ),
        Text(
          txt,
          style: TextStyle(
            color: MyColors.primaryColor,
            fontSize: 16
          ),
        ),
      ],
    ));
  }
}
