import 'package:easy_localization/easy_localization.dart';
import '/business_logic/points/points_cubit.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../utilities/constants/colors.dart';
import '../../widgets/no_internet_widget.dart';

class ExpansionTilePoints extends StatelessWidget {
  const ExpansionTilePoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return const CustomExpansionTilePoints();
          // widget with initState   -->   apis
        } else {
          return child;
        }
      },
      child: NoInternetWidget(
        txt: tr(StringConstants.noInternet),
      ),
    );
  }
}

class CustomExpansionTilePoints extends StatefulWidget {
  const CustomExpansionTilePoints({Key? key}) : super(key: key);

  @override
  State<CustomExpansionTilePoints> createState() =>
      _CustomExpansionTilePointsState();
}

class _CustomExpansionTilePointsState extends State<CustomExpansionTilePoints> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      BlocProvider.of<PointsCubit>(context).index = -1;

      BlocProvider.of<PointsCubit>(context).selectedFun(-1, -1);


      BlocProvider.of<PointsCubit>(context).getPoints().then((value)  {

        isLoading = false;
      } );
    });
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (isLoadingMore || isLoading)
        return; // Exit if already loading more or initial loading is in progress
      setState(() {
        isLoadingMore = true;
      });
      if (BlocProvider.of<PointsCubit>(context).currentPage <
          BlocProvider.of<PointsCubit>(context).numberOfPages) {
        BlocProvider.of<PointsCubit>(context).currentPage += 1;

        await _loadMorePoints();
      }
      setState(() {
        isLoadingMore = false;
      });
    } else {
      debugPrint('##--do not call--##');
    }
  }

  Future<void> _loadMorePoints() async {
    setState(() {
      isLoading = true;
    });
     BlocProvider.of<PointsCubit>(context).getPoints().then((value)  {
       setState(() {
         isLoading = false;
       });
     } );

  }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(_scrollListener);
  //   BlocProvider.of<PointsCubit>(context).close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PointsCubit, PointsState>(
      listener: (context, state) {
        print(state.toString());
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: BlocProvider.of<PointsCubit>(context).json.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < BlocProvider.of<PointsCubit>(context).json.length) {
                bool isSelected =
                    BlocProvider.of<PointsCubit>(context).index == index;
                bool selected =
                    BlocProvider.of<PointsCubit>(context).selectedTileIndex ==
                        index;
                return BlocProvider.of<PointsCubit>(context).json.isEmpty
                    ? Center(
                        child: Text(
                        tr(StringConstants.thereIsNoData),
                        style:
                            TextStyle(fontSize: 20, color: MyColors.grayText),
                      ))
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: isSelected&&selected
                            //     ? MyColors.primaryColor
                            //     : MyColors.lightGray,
                            border: Border.all(color: MyColors.deepGray)),
                        child: ListTileTheme(
                          tileColor: isSelected && selected
                              ? MyColors.primaryColor
                              : MyColors.lightGray,
                          // selectedTileColor: isSelected
                          //     ? MyColors.primaryColor
                          //     : MyColors.lightGray,
                          // selectedColor: isSelected
                          //     ? MyColors.primaryColor
                          //     : MyColors.lightGray,

                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: FittedBox(
                              child: Text(
                                '${tr(StringConstants.album)}  ${BlocProvider.of<PointsCubit>(context).json[index].id}   |  ${tr(StringConstants.dateCreated)}  ${BlocProvider.of<PointsCubit>(context).json[index].createdAt.split(" ")[0]}   |  ${tr(StringConstants.pointsBalance)}  ${BlocProvider.of<PointsCubit>(context).json[index].balance}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: isSelected && selected
                                      ? MyColors.myYellow
                                      : MyColors.primaryColor,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.018,
                                backgroundColor: MyColors.myYellow,
                                child: isSelected && selected
                                    ? const Icon(
                                        CupertinoIcons.minus,
                                        color: MyColors.primaryColor,
                                        size: 15,
                                      )
                                    : const Icon(
                                        CupertinoIcons.add,
                                        color: MyColors.colorWhite,
                                        size: 15,
                                      )),
                            onExpansionChanged: (bool expanded) {
                              BlocProvider.of<PointsCubit>(context,
                                      listen: false)
                                  .selectedFun(index, index);
                              BlocProvider.of<PointsCubit>(context,
                                      listen: false)
                                  .selectedTileIndex = expanded ? index : -1;
                            },
                            children: <Widget>[
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: MyColors.myWhite,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.myWhite,
                                              border: Border.all(
                                                  color: MyColors.myGray)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                tr(StringConstants.on_him),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyColors.primaryColor),
                                              ),
                                              Text(
                                                  '${BlocProvider.of<PointsCubit>(context).json[index].onHim}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.myWhite,
                                              border: Border.all(
                                                  color: MyColors.myGray)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(tr(StringConstants.for_him),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor)),
                                              Text(
                                                  '${BlocProvider.of<PointsCubit>(context).json[index].forHim}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.myWhite,
                                              border: Border.all(
                                                  color: MyColors.myGray)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(tr(StringConstants.balance),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor)),
                                              Text(
                                                  '${BlocProvider.of<PointsCubit>(context).json[index].balance}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.myWhite,
                                              border: Border.all(
                                                  color: MyColors.myGray)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(tr(StringConstants.point),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor)),
                                              Text(
                                                  '${BlocProvider.of<PointsCubit>(context).json[index].point}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: MyColors
                                                          .primaryColor))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              } else {
                return BlocProvider.of<PointsCubit>(context).currentPage <
                        BlocProvider.of<PointsCubit>(context).numberOfPages
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      )
                    : SizedBox(
                        height: 10,
                      );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        );
      },
    );
  }
}
