import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class CustomContainerForDetailsRequest extends StatelessWidget {
  const CustomContainerForDetailsRequest({Key? key, required this.txt})
      : super(key: key);

  final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: MyColors.myGray.withOpacity(0.3),
          border: Border.all(
            color: MyColors.myGray,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        txt,
        style: TextStyle(color: MyColors.myBlack.withOpacity(0.5)),
      ),
    );
  }
}
