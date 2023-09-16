
import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';

class TextAlignForRequestAlbum extends StatelessWidget {
  const TextAlignForRequestAlbum({Key? key, required this.title,  this.color = MyColors.myBlack})
      : super(key: key);

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                color: color
            ),
            textAlign: TextAlign.start,

          ),
        ),

      ],
    );
  }
}