import '/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

class InputFormFieldWithoutHeader extends StatelessWidget {
  InputFormFieldWithoutHeader(
      {Key? key,
      required this.hintText,
      this.maxLines,
      this.type = TextInputType.text,
      required this.controller})
      : super(key: key);
  final String hintText;
  final TextInputType type;
  int? maxLines = 1;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      validator: (nn) {
        if (nn == null || nn.trim().isEmpty) {
          return "this field is required";
        }
      },
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MyColors.deepGray)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: MyColors.primaryColor)),
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColors.deepGray),
      ),
      cursorColor: MyColors.primaryColor,
      maxLines: maxLines,
    );
  }
}
