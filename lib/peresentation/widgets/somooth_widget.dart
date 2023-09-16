import '/business_logic/slider/slider_cubit.dart';
import '/utilities/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class SmoothComponent extends StatelessWidget {
  const SmoothComponent({Key? key, required this.length}) : super(key: key);


  final int length;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(
          top:5.0,
          bottom: MediaQuery.of(context).size.height*0.02
      ),
      child:  AnimatedSmoothIndicator(
        effect: const SlideEffect(
          dotColor: MyColors.myWhite,
          activeDotColor: MyColors.myYellow,
        ),
        activeIndex: BlocProvider.of<SliderCubit>(context).indexOfSlider,

        count: length
    )
    );
  }
}