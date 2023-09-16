import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/string_constants.dart';

class OccasionDateTemplate extends StatelessWidget {
  const OccasionDateTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(StringConstants.dateOfCelebration),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.myGray,
              ),
              borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(PhotosConstants.calenderG),
              const SizedBox(
                width: 10,
              ),
              const Text(StringConstants.history),
              const Spacer(),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset("assets/images/blue_container.png"),
                  SvgPicture.asset(PhotosConstants.calenderW)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
