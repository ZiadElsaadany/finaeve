import '/utilities/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../models/list_models.dart';

class DropDownButtonTemplate extends StatelessWidget {
  DropDownButtonTemplate({
    Key? key,
    required this.text,
    this.items,
    this.onChanged,
    this.value,
  }) : super(key: key);

  // final List<String> dropdownItems = ['Item 1', 'Item 2', 'Item 3'];
  // String selectedItem = ""; // Initially selected item
  final String text;
  final String? value;

  final void Function(String?)? onChanged;

  List<BaseIdNameModel>? items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            text,
            style:  Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: MyColors.myBlack,
              fontSize: 12,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.myGray),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: [
              SvgPicture.asset(PhotosConstants.albumIconG),
              // Your desired icon
              const SizedBox(width: 8.0),
              // Space between icon and label
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    // To take all possible horizontal space
                    value: value,
                    onChanged: onChanged,

                    items: items?.map<DropdownMenuItem<String>>(
                          (item) {
                            return DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(item.name),
                            );
                          },
                        ).toList() ??
                        [],
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
