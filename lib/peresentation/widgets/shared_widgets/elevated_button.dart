import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class ElevatedButtonTemplate extends StatelessWidget {
  const ElevatedButtonTemplate(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.onPressed})
      : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: MyColors.colorWhite,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }
}
