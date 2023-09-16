import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class TextFormFieldTemplate extends StatelessWidget {
  const TextFormFieldTemplate({
    Key? key,
     this.prefixIcon,
    required this.hintText,
    required this.validator,
    this.controller,
    this.suffixIcon, this.type= TextInputType.text,
    this.obscureText = false
  }) : super(key: key);
  final Widget ?prefixIcon;
  final Widget? suffixIcon;

  final TextInputType ?  type;

  final String hintText;
  final bool? obscureText ;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:type ,
      obscureText:obscureText! ,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon:  suffixIcon,
        iconColor: MyColors.myGray,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: MyColors.deepGray,
          fontSize: 14,
        ),
        suffixIconColor: Colors.red,
        prefixIconColor: MyColors.myGray,
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: MyColors.myGray)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: MyColors.myGray),
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red)),
      ),
      cursorColor: MyColors.primaryColor,

      validator: validator,
      controller: controller,
    );
  }
}
