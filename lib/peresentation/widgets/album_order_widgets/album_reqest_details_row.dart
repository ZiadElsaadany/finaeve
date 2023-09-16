import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';

class AlbumRequestDetailsRow extends StatelessWidget {
  const AlbumRequestDetailsRow(
      {Key? key, required this.text, required this.index})
      : super(key: key);
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
        listener: (ctx, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              print("hello");
              BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .changeIndexOfSelectedRequestOfAlbum(
                      indexOfSelectedRequestOfAlbum: index);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.075,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: BlocProvider.of<AlbumDetailsRowCubit>(context)
                            .indexOfSelectedRequestOfAlbum ==
                        index
                    ? MyColors.myYellow
                    : MyColors.myYellow.withOpacity(0.5),
              ),
              child: FittedBox(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          );
        });
  }
}
