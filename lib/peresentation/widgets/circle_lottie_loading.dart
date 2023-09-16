import 'package:evephotography/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class CircleLoadingByLottie extends StatelessWidget {
  const CircleLoadingByLottie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(

  child:CircularProgressIndicator(
    color: MyColors.primaryColor,
  )
    );
  }
}
