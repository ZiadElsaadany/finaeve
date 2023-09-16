import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';

class WarningTemplate extends StatelessWidget {
  const WarningTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.warningFill,
          border: Border.all(color: MyColors.warningBorder),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.022,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child:  FittedBox(
        child: Row(
          children: [
            Text(tr(StringConstants.withPrintAlbumErrorText),style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: MyColors.myBlack,
              fontSize: 14,
            ),),
          ],
        ),
      ),
    );
  }
}
