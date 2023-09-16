import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class CardForWithoutPrintSpecifications extends StatelessWidget {
  const CardForWithoutPrintSpecifications({Key? key}) : super(key: key);
  final bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.005,
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              StringConstants.accessories,
              style: TextStyle(fontSize: 14, color: MyColors.myGray),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    activeColor: MyColors.primaryColor,
                    side: const BorderSide(
                      color: MyColors.myGray,
                    ),
                    checkColor: MyColors.primaryColor,
                    // fillColor: MyColors.myYellow,
                    value: _isChecked,
                    onChanged: (bool? value) {

                    },
                    materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text(
                    StringConstants.miniAlbum,
                    style:
                    TextStyle(color: MyColors.myGray),
                  ),
                ],
              ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Checkbox(
                        activeColor: MyColors.primaryColor,
                        side: const BorderSide(
                          color: MyColors.myGray,
                        ),
                        checkColor: MyColors.primaryColor,
                        // fillColor: MyColors.myYellow,
                        value: _isChecked,
                        onChanged: (bool? value) {

                        },
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Text(
                        StringConstants.painting,
                        style:
                        TextStyle(color: MyColors.myGray),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Checkbox(
                        activeColor: MyColors.primaryColor,
                        side: const BorderSide(
                          color: MyColors.myGray,
                        ),
                        checkColor: MyColors.primaryColor,
                        // fillColor: MyColors.myYellow,
                        value: _isChecked,
                        onChanged: (bool? value) {

                        },
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Text(
                        StringConstants.magazineOrFolded,
                        style:
                        TextStyle(color: MyColors.myGray),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
