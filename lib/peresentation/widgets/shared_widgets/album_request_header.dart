import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../models/list_models.dart';
import '../album_order_widgets/album_reqest_details_row.dart';
import 'header_text.dart';

class AlbumRequestHeader extends StatefulWidget {
  final int  index ;
   AlbumRequestHeader({Key? key,  this.index=0}) : super(key: key);

  @override
  State<AlbumRequestHeader> createState() => _AlbumRequestHeaderState();
}

class _AlbumRequestHeaderState extends State<AlbumRequestHeader> {
  final ScrollController _scrollController = ScrollController();

  final Duration _duration = const Duration(milliseconds: 500);

   void scrollToIndex(int index) {
     double itemExtent = 90.0; // Height of each item in the list
     _scrollController.animateTo(
       index * itemExtent,
       duration: _duration,
       curve: Curves.easeInOut,
     );
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(widget.index);
    });
  }
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeaderText(
          text: tr(StringConstants.albumOrder),
        ),
        Text(
          tr(StringConstants.uCanChooseTheAlbumType),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: MyColors.grayText,
                fontSize: 14,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          // width: MediaQuery.of(context).size.width,
          child: BlocConsumer<ListsCubit, ListsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (BlocProvider.of<ListsCubit>(context).dataAllMenues != null) {
                return ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: BlocProvider.of<ListsCubit>(context)
                      .dataAllMenues!
                      .albumTypesOrder!
                      .length,
                  itemBuilder: (ctx, index) {
                    return AlbumRequestDetailsRow(
                      text: BlocProvider.of<ListsCubit>(context)
                          .dataAllMenues!
                          .albumTypesOrder![index]
                          .name,
                      index: index,
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}

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
              BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .changeIndexOfSelectedRequestOfAlbum(
                      indexOfSelectedRequestOfAlbum: index);
              BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .restartAlbumPrintState();
              BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .restartIndexOfAlbumWithoutCircleAvatarPrint();
              BlocProvider.of<ListsCubit>(context).restartPrice();
              BlocProvider.of<ListsCubit>(context).funGetPrice(context);
              if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum ==
                  0) {
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage1InAlbumWithPrint(b: false);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage2InAlbumWithPrint(b: false);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage3InAlbumWithPrint(b: false);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage4InAlbumWithPrint(b: false);
              } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum ==
                  1) {
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage1InAlbumWithoutPrint(b: false);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage2InAlbumWithoutPrint(b: false);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage3InAlbumWithoutPrint(b: false);
              } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum ==
                  2) {
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage1InAlbumFiller(b: false);
              } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum ==
                  3) {
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage1InAlbumAccessories(b: false);
              } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum ==
                  4) {
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotInAlbumLPaint(b: false);
              }
            },
            child: Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: BlocProvider.of<AlbumDetailsRowCubit>(context)
                            .indexOfSelectedRequestOfAlbum ==
                        index
                    ? MyColors.myYellow
                    : MyColors.myYellow.withOpacity(0.5),
              ),
              child: Text(text,
                  style:
                      const TextStyle(fontSize: 16, color: MyColors.myWhite)),
            ),
          );
        });
  }

}
