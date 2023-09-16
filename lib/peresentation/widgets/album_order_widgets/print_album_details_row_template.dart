import 'package:easy_localization/easy_localization.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import 'circle_avatar_album_order.dart';

class PrintAlbumDetailsRow extends StatelessWidget {
  const PrintAlbumDetailsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
        listener: (cxt, state) {},
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyCircleAvatarTemplate(
                  index: 0,
                  text: tr(StringConstants.albumSpecifications),
                  photo: PhotosConstants.albumSpecificationsIconW,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyCircleAvatarTemplate(
                  index: 1,
                  photo: BlocProvider.of<AlbumDetailsRowCubit>(context)
                              .indexOfAlbumPrint >=1
                      ? PhotosConstants.albumMaterialIconW
                      : PhotosConstants.albumMaterialIconG,
                  text: tr(StringConstants.albumMaterials),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyCircleAvatarTemplate(
                  index: 2,
                  photo: BlocProvider.of<AlbumDetailsRowCubit>(context)
                              .indexOfAlbumPrint >=2
                      ? PhotosConstants.albumDataIconW
                      : PhotosConstants.albumDataIconG,
                  text: tr(StringConstants.albumData),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyCircleAvatarTemplate(
                  index: 3,
                  photo: BlocProvider.of<AlbumDetailsRowCubit>(context)
                              .indexOfAlbumPrint
                          >=3
                      ? PhotosConstants.endOderIconW
                      : PhotosConstants.endOderIconG,
                  text: tr(StringConstants.endOrder),
                ),
              ],
            ),
          );
        });
  }
}
