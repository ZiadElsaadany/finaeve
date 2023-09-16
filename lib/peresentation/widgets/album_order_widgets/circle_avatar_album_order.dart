import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';

class MyCircleAvatarTemplate extends StatelessWidget {
  const MyCircleAvatarTemplate(
      {Key? key,
      required this.photo,
      required this.text,
      required this.index})
      : super(key: key);
  final String photo;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35.0,
          backgroundColor: index <=
                  BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfAlbumPrint
              ? MyColors.primaryColor
              : MyColors.lightGray,
          child: SvgPicture.asset(photo),
        ),
        Text(
          text,
          style: TextStyle(
            color: index <=
                    BlocProvider.of<AlbumDetailsRowCubit>(context)
                        .indexOfAlbumPrint
                ? MyColors.primaryColor
                : MyColors.myBlack,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
