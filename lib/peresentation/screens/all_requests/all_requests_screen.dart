import 'package:easy_localization/easy_localization.dart';
import '/business_logic/all_requests_cubit/all_request_states.dart';
import '/peresentation/screens/all_requests/request_details_screen.dart';
import '/utilities/constants/api_constants.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/all_requests_cubit/all_request_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/header_text.dart';

class AllRequestsScreen extends StatelessWidget {
  const AllRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const CustomAllRequestsScreen();
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

class CustomAllRequestsScreen extends StatefulWidget {
  const CustomAllRequestsScreen({Key? key}) : super(key: key);

  @override
  State<CustomAllRequestsScreen> createState() =>
      _CustomAllRequestsScreenState();
}

class _CustomAllRequestsScreenState extends State<CustomAllRequestsScreen> {
  final List<String> lst = [
    tr(StringConstants.newOrders),
    tr(StringConstants.inProgressOrders),
    tr(StringConstants.finishOrders)
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      BlocProvider.of<AllRequestCubit>(context).selectedAllRequests = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllRequestCubit, AllRequestStates>(
      listener: (context, state) {
        if (state is FailureMyOrdersArchiveState) {
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
                child: HeaderText(text: tr(StringConstants.allRequests)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lst.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<AllRequestCubit>(context)
                            .changeIndexOfAllRequests(index: index);
                      },
                      child: Container(
                          alignment: AlignmentDirectional.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: BlocProvider.of<AllRequestCubit>(context)
                                          .selectedAllRequests ==
                                      index
                                  ? MyColors.primaryColor
                                  : MyColors.myWhite,
                              border: Border.all(color: MyColors.myGray)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              lst[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      BlocProvider.of<AllRequestCubit>(context)
                                                  .selectedAllRequests ==
                                              index
                                          ? MyColors.myWhite
                                          : MyColors.myBlack.withOpacity(0.4)),
                            ),
                          )),
                    );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocProvider.of<AllRequestCubit>(context).selectedAllRequests == 0
                ? NewOrdersScreen()
                : BlocProvider.of<AllRequestCubit>(context)
                            .selectedAllRequests ==
                        1
                    ? InProgressOrdersScreen()
                    :BlocProvider.of<AllRequestCubit>(context)
                .selectedAllRequests ==2?    EndedOrdersScreen():SizedBox(),
            const SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }
}

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      BlocProvider.of<AllRequestCubit>(context).currentPage =1;

      BlocProvider.of<AllRequestCubit>(context).archiveOrders = [] ;
    });
    Future.delayed(Duration.zero, () {

      BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
          indexOfRequest: 0, endPoint: ApiConstants.getOrderInfo0AllReq).then((value) {
        setState(() {
          isLoading = false;
        });
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
      if (BlocProvider.of<AllRequestCubit>(context).currentPage <
          BlocProvider.of<AllRequestCubit>(context).numOfPage) {
        BlocProvider.of<AllRequestCubit>(context).currentPage += 1;

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
     BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
        indexOfRequest: 0, endPoint: ApiConstants.getOrderInfo0AllReq).then((value) {
       setState(() {
         isLoading = false;
       });
     });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount:
            BlocProvider.of<AllRequestCubit>(context).archiveOrders.length + 1,
        itemBuilder: (ctx, index) {
          if (index <
              BlocProvider.of<AllRequestCubit>(context).archiveOrders.length) {
            return BlocProvider.of<AllRequestCubit>(context)
                    .archiveOrders
                    .isEmpty
                ? Center(
                    child: Text(
                    tr(StringConstants.thereIsNoData),
                    style: TextStyle(fontSize: 20, color: MyColors.grayText),
                  ))
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RequestDetailsScreen(
                              num: BlocProvider.of<AllRequestCubit>(context)
                                  .archiveOrders[index]
                                  .id,
                              data: BlocProvider.of<AllRequestCubit>(context)
                                      .archiveOrders[index]
                                      .created_at ??
                                  "",
                              status: BlocProvider.of<AllRequestCubit>(context)
                                      .archiveOrders[index]
                                      .status ??
                                  "")));
                    },
                    child: ItemOfRequest(
                      number: BlocProvider.of<AllRequestCubit>(context)
                          .archiveOrders[index]
                          .id,
                      status: BlocProvider.of<AllRequestCubit>(context)
                          .archiveOrders[index]
                          .status,
                      date: BlocProvider.of<AllRequestCubit>(context)
                          .archiveOrders[index]
                          .created_at,
                    ));
          }
          else {
            return BlocProvider.of<AllRequestCubit>(context).currentPage <
                    BlocProvider.of<AllRequestCubit>(context).numOfPage
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
      ),
    );
  }
}

class InProgressOrdersScreen extends StatefulWidget {
  const InProgressOrdersScreen({Key? key}) : super(key: key);

  @override
  State<InProgressOrdersScreen> createState() => _InProgressOrdersScreenState();
}

class _InProgressOrdersScreenState extends State<InProgressOrdersScreen> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        BlocProvider.of<AllRequestCubit>(context).currentPage =1;

        BlocProvider.of<AllRequestCubit>(context).inProgressOrders = [] ;
      });
      BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
          indexOfRequest: 1, endPoint: ApiConstants.myOrderInProgressAllReq).then((value)  {

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
      if (BlocProvider.of<AllRequestCubit>(context).currentPage <
          BlocProvider.of<AllRequestCubit>(context).numOfPage) {
        BlocProvider.of<AllRequestCubit>(context).currentPage += 1;

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
     BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
        indexOfRequest: 1, endPoint: ApiConstants.myOrderInProgressAllReq).then((value)  {
       setState(() {
         isLoading = false;
       });
     });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: BlocProvider.of<AllRequestCubit>(context)
                      .inProgressOrders
                      .length +
                  1,
              itemBuilder: (ctx, index) {
                if (index <
                    BlocProvider.of<AllRequestCubit>(context)
                        .inProgressOrders
                        .length) {
                  return BlocProvider.of<AllRequestCubit>(context).inProgressOrders.isEmpty
                      ? Center(
                      child: Text(
                        tr(StringConstants.thereIsNoData),
                        style: TextStyle(fontSize: 20, color: MyColors.grayText),
                      ))
                      : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RequestDetailsScreen(
                                num: BlocProvider.of<AllRequestCubit>(context)
                                    .inProgressOrders[index]
                                    .id,
                                data: BlocProvider.of<AllRequestCubit>(context)
                                        .inProgressOrders[index]
                                        .created_at ??
                                    "",
                                status:
                                    BlocProvider.of<AllRequestCubit>(context)
                                            .inProgressOrders[index]
                                            .status ??
                                        "")));
                      },
                      child: ItemOfRequest(
                        number: BlocProvider.of<AllRequestCubit>(context)
                            .inProgressOrders[index]
                            .id,
                        status: BlocProvider.of<AllRequestCubit>(context)
                            .inProgressOrders[index]
                            .status,
                        date: BlocProvider.of<AllRequestCubit>(context)
                            .inProgressOrders[index]
                            .created_at,
                      ));
                } else {
                  return BlocProvider.of<AllRequestCubit>(context).currentPage <
                          BlocProvider.of<AllRequestCubit>(context).numOfPage
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
            ),
    );
  }
}

class EndedOrdersScreen extends StatefulWidget {
  const EndedOrdersScreen({Key? key}) : super(key: key);

  @override
  State<EndedOrdersScreen> createState() => _EndedOrdersScreenState();
}

class _EndedOrdersScreenState extends State<EndedOrdersScreen> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        BlocProvider.of<AllRequestCubit>(context).currentPage =1;

        BlocProvider.of<AllRequestCubit>(context).endedOrders = [] ;
      });
      BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
          indexOfRequest: 2, endPoint: ApiConstants.myOrderCompleteAllReq).then((value)  {
        debugPrint(
            "date is ${
                BlocProvider.of<AllRequestCubit>(context).endedOrders[0].created_at.toString()
            }"
        );
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
      if (BlocProvider.of<AllRequestCubit>(context).currentPage <
          BlocProvider.of<AllRequestCubit>(context).numOfPage) {
        BlocProvider.of<AllRequestCubit>(context).currentPage += 1;

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
    await BlocProvider.of<AllRequestCubit>(context).getBouquetsInformation(
        indexOfRequest: 2, endPoint: ApiConstants.myOrderCompleteAllReq).then((value){
      setState(() {
        isLoading = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount:
        BlocProvider.of<AllRequestCubit>(context).endedOrders.length + 1,
        itemBuilder: (ctx, index) {
          if (index <
              BlocProvider.of<AllRequestCubit>(context).endedOrders.length) {
            return BlocProvider.of<AllRequestCubit>(context)
                .endedOrders
                .isEmpty
                ? Center(
                child: Text(
                  tr(StringConstants.thereIsNoData),
                  style: TextStyle(fontSize: 20, color: MyColors.grayText),
                ))
                : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestDetailsScreen(
                          num: BlocProvider.of<AllRequestCubit>(context)
                              .endedOrders[index]
                              .id,
                          data: BlocProvider.of<AllRequestCubit>(context)
                              .endedOrders[index]
                              .created_at ??
                              "",
                          status: BlocProvider.of<AllRequestCubit>(context)
                              .endedOrders[index]
                              .status ??
                              "")));
                },
                child: ItemOfRequest(
                  number: BlocProvider.of<AllRequestCubit>(context)
                      .endedOrders[index]
                      .id,
                  status: BlocProvider.of<AllRequestCubit>(context)
                      .endedOrders[index]
                      .status,
                  date: BlocProvider.of<AllRequestCubit>(context)
                      .endedOrders[index]
                      .created_at,
                ));
          }
          else {
            return BlocProvider.of<AllRequestCubit>(context).currentPage <
                BlocProvider.of<AllRequestCubit>(context).numOfPage
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
      ),
    );
  }
}

class ItemOfRequest extends StatelessWidget {
  ItemOfRequest({Key? key, this.number = 0, this.date = "", this.status = ""})
      : super(key: key);

  dynamic number;
  String? date;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.007,
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      PhotosConstants.eveLogo,
                      fit: BoxFit.contain,
                    )

                    //
                    // Image.asset(
                    //   ImageConstants.eve_logo,fit: BoxFit.cover,),
                    ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        color: MyColors.grayText,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          "${tr(StringConstants.orderNum)}:",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: MyColors.myWhite),
                        ),
                        Expanded(
                          child: Text(
                            number.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: MyColors.myWhite),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.grayText,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          tr(StringConstants.date),
                          style: const TextStyle(
                              fontSize: 16, color: MyColors.myWhite),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            date?.split(" ")[0] ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: MyColors.myWhite),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          tr(StringConstants.status),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, color: MyColors.myWhite),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            status ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: MyColors.myWhite),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
