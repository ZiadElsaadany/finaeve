import 'package:easy_localization/easy_localization.dart';
import '/business_logic/my_plan_order/my_plan_order_cubit.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/header_text.dart';

class ReservedBouquets extends StatelessWidget {
  const ReservedBouquets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const CustomReservedBouquets();
            // widget with initState   -->   apis
          } else {
            return child;
          }
        },
        child: NoInternetWidget(
          txt: tr(StringConstants.noInternet),
        ),
      ),
    );
  }
}

class CustomReservedBouquets extends StatefulWidget {
  const CustomReservedBouquets({Key? key}) : super(key: key);

  @override
  State<CustomReservedBouquets> createState() => _CustomReservedBouquetsState();
}

class _CustomReservedBouquetsState extends State<CustomReservedBouquets> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        isLoading = true;
        BlocProvider.of<MyPlanOrderCubit>(context).myPlanOrder = [] ;
        BlocProvider.of<MyPlanOrderCubit>(context).currentPage = 1 ;
      });

      BlocProvider.of<MyPlanOrderCubit>(context).getMyPlanOrder().then((value)  {
        isLoading = false;
      });
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
      if (BlocProvider.of<MyPlanOrderCubit>(context).currentPage <
          BlocProvider.of<MyPlanOrderCubit>(context).numberOfPages) {
        BlocProvider.of<MyPlanOrderCubit>(context).currentPage += 1;

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
     BlocProvider.of<MyPlanOrderCubit>(context).getMyPlanOrder().then((value)   {
       setState(() {
         isLoading = false;
       });
     });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyPlanOrderCubit, MyPlanOrderState>(
      listener: (context, state) {
        if (state is FailureMyPlanOrderState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: HeaderText(text: tr(StringConstants.reversedBouquets)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: BlocProvider.of<MyPlanOrderCubit>(context)
                              .myPlanOrder
                              .length +
                          1,
                      itemBuilder: (ctx, index) {
                        if (index <
                            BlocProvider.of<MyPlanOrderCubit>(context)
                                .myPlanOrder
                                .length) {
                          return

                            BlocProvider.of<MyPlanOrderCubit>(context)
                                .myPlanOrder
                                .isEmpty
                                ? Center(
                                child: Text(
                                  tr(StringConstants.thereIsNoData),
                                  style: TextStyle(fontSize: 20, color: MyColors.grayText),
                                ))
                                :
                            Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.24,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.01,
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.0389),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: MyColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: SvgPicture.asset(
                                                PhotosConstants.eveLogo,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: MyColors.myYellow,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06),
                                            child: Text(
                                              '${BlocProvider.of<MyPlanOrderCubit>(context).myPlanOrder[index].price} ${tr(StringConstants.SAR)}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: MyColors.myWhite,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              BlocProvider.of<MyPlanOrderCubit>(
                                                      context)
                                                  .myPlanOrder[index]
                                                  .planId,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors.primaryColor),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 10),
                                              color: const Color(0xff0CBB73),
                                              child: Text(
                                                BlocProvider.of<
                                                            MyPlanOrderCubit>(
                                                        context)
                                                    .myPlanOrder[index]
                                                    .status,
                                                style: const TextStyle(
                                                    color: MyColors.myWhite,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomContainerTimeAndDate(
                                                  txt:
                                                      "${tr(StringConstants.orderNum)} | ${BlocProvider.of<MyPlanOrderCubit>(context).myPlanOrder[index].id}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomContainerTimeAndDate(
                                                  txt:
                                                      "${tr(StringConstants.orderDate)} | ${BlocProvider.of<MyPlanOrderCubit>(context).myPlanOrder[index].date}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomContainerTimeAndDate(
                                                  txt:
                                                      "${tr(StringConstants.reservationTime)} | ${BlocProvider.of<MyPlanOrderCubit>(context).myPlanOrder[index].time}"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return BlocProvider.of<MyPlanOrderCubit>(context)
                                      .currentPage <
                                  BlocProvider.of<MyPlanOrderCubit>(context)
                                      .numberOfPages
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.primaryColor,
                                  ),
                                )
                              : SizedBox(
                                  height: 10,
                                );
                        }
                        // else {
                        //   return isLoadingMore || isLoading
                        //       ? const Center(
                        //           child: CircularProgressIndicator(
                        //           color: MyColors.myYellow,
                        //         ))
                        //       : const SizedBox.shrink();
                        // }
                      },
                    ),
            )
          ],
        );
      },
    );
  }
}

class CustomContainerTimeAndDate extends StatelessWidget {
  const CustomContainerTimeAndDate({Key? key, required this.txt})
      : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
          color: MyColors.myGray.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.myBlack.withOpacity(0.5))),
      child: Text(
        txt,
        maxLines: 2,
        style: const TextStyle(color: MyColors.primaryColor, fontSize: 14),
      ),
    );
  }
}
