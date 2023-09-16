import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilities/constants/colors.dart';

class RectangleTemplate extends StatelessWidget {
  const RectangleTemplate({Key? key, required this.image, required this.txt})
      : super(key: key);
  final String image;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
        border: Border.all(color: MyColors.deepGray),
        // border: Border(bottom:  BorderSide(color: MyColors.deepGray),top:BorderSide(color: MyColors.deepGray),left: BorderSide(color: MyColors.deepGray) ),
        color: MyColors.myWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(8),
                bottomStart: Radius.circular(8),
              ),
              color: MyColors.myYellow,
            ),
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
                horizontal: 10),
            child: SvgPicture.asset(
              image,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(8),
                    bottomEnd: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    txt,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
