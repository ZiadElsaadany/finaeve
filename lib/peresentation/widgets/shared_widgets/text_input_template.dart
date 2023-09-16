import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class TextInputTemplate extends StatelessWidget {
  const TextInputTemplate({
    Key? key,
    this.controller,
    required this.hintText, required this.headerTxt, this.onChanged,  this.initialValue="",
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final String headerTxt;
  final String initialValue;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Align(
          alignment: Alignment.bottomRight,
          child: Text(
            headerTxt,
            style:  Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: MyColors.myBlack,
              fontSize: 14,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: MyColors.grayText,
              fontSize: 14,
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: MyColors.deepGray)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: MyColors.deepGray),
            ),
          ),
          maxLines: 3,
          cursorColor: MyColors.deepGray,
        ),
      ],
    );
  }
}
