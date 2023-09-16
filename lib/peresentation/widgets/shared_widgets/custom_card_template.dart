import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/constants/colors.dart';

class CustomCardTemplate extends StatefulWidget {
  const CustomCardTemplate(
      {Key? key,
      required this.txt,
      this.yesOnTap,
      this.noOnTap,
      this.isChecked = false})
      : super(key: key);

  final String txt;
  final void Function()? yesOnTap;
  final void Function()? noOnTap;
  final bool isChecked;

  @override
  State<CustomCardTemplate> createState() => _CustomCardTemplateState();
}

class _CustomCardTemplateState extends State<CustomCardTemplate> {
  ///todo: check circular check button
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(widget.txt),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: MyColors.grayText,
                fontSize: 14,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.yesOnTap,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColors.myGray, width: 2),
                          color: widget.isChecked
                              ? MyColors.primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Text(
                      tr(StringConstants.yes),
                      style:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.grayText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.noOnTap,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: MyColors.myGray, width: 2),
                            color: widget.isChecked
                                ? Colors.transparent
                                : MyColors.primaryColor),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Text(
                      tr(StringConstants.no),
                      style:
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.grayText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
