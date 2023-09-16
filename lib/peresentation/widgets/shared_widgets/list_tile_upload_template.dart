import '/business_logic/Lists/lists_cubit.dart';
import '/utilities/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';

class ListTileUploadTemplate extends StatelessWidget {
  const ListTileUploadTemplate({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit
    , ListsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
              vertical: 3
          ),
          decoration: BoxDecoration(
              color: MyColors.myGray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            onTap:(){
              BlocProvider.of<ListsCubit>(context).getImageFromGallery();
            },

            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(PhotosConstants.uploadPhotoG),
                const SizedBox(
                  height: 8,
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
