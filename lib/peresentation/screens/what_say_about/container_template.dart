import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';

class ContainerWhatSayTemplate extends StatelessWidget {
  const ContainerWhatSayTemplate(
      {Key? key, required this.txt1, required this.txt2, required this.txt3})
      : super(key: key);
  final String txt1;
  final String txt2;
  final String txt3;

  @override
  Widget build(BuildContext context) {
    return context.locale == const Locale("en")
        ? Stack(alignment: Alignment.bottomRight, children: [
            Stack(children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        border:
                            Border.all(color: MyColors.grayBorder, width: 3),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          tr(StringConstants.whatSay),
                          style: const TextStyle(
                              color: MyColors.primaryColor, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          txt1,
                          style: const TextStyle(
                              color: MyColors.myBlack, fontSize: 16),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          txt2,
                          style: const TextStyle(
                              color: MyColors.primaryColor, fontSize: 16),
                        ),
                        Text(
                          txt3,
                          style: const TextStyle(
                              color: MyColors.myBlack, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.035),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(PhotosConstants.vec1)),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    PhotosConstants.vec2,
                  )),
            )
          ])
        : Stack(alignment: Alignment.bottomLeft, children: [
            Stack(children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        border:
                            Border.all(color: MyColors.grayBorder, width: 3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          tr(StringConstants.whatSay),
                          style: const TextStyle(
                              color: MyColors.primaryColor, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          txt1,
                          style: const TextStyle(
                              color: MyColors.myBlack, fontSize: 16),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          txt2,
                          style: const TextStyle(
                              color: MyColors.primaryColor, fontSize: 16),
                        ),
                        Text(
                          txt3,
                          style: const TextStyle(
                              color: MyColors.myBlack, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.035),
                child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(PhotosConstants.vec1)),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(
                    PhotosConstants.vec2,
                  )),
            )
          ]);
  }
}
