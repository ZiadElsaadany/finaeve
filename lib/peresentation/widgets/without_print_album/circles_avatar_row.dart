import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/without_print_album/circle_avatar_template_without_print.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/images.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/photos.dart';

class CirclesAvatarRow extends StatelessWidget {
  const CirclesAvatarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
        listener: (cxt, state) {},
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              CircleAvatarTemplateForWithoutPrintScreen(
                index: 0,
                photo: PhotosConstants.albumSpecificationsIconW,
                text: tr(StringConstants.albumSpecifications),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              CircleAvatarTemplateForWithoutPrintScreen(
                index: 1,
                photo: BlocProvider.of<AlbumDetailsRowCubit>(context)
                            .indexOfAlbumWithoutCircleAvatarPrint >=
                        1
                    ? PhotosConstants.albumMaterialIconW
                    : PhotosConstants.albumMaterialIconG,
                text: tr(StringConstants.albumMaterials),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              CircleAvatarTemplateForWithoutPrintScreen(
                index: 2,
                photo: BlocProvider.of<AlbumDetailsRowCubit>(context)
                    .indexOfAlbumWithoutCircleAvatarPrint >=
                    2
                    ? PhotosConstants.albumDataIconW
                    : PhotosConstants.albumDataIconG,
                text: tr(StringConstants.albumData),
              ),
            ]),
          );
        });
  }
}
