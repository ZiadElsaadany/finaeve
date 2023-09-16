import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/bouquets/bouquets_cubit.dart';
import '/peresentation/screens/bouquet/request_bouquet_screen.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/shared_widgets/elevated_button.dart';

class ListContent extends StatefulWidget {
  const ListContent({Key? key}) : super(key: key);

  @override
  State<ListContent> createState() => _ListContentState();
}

class _ListContentState extends State<ListContent> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = false; // Add isLoading variable

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
      BlocProvider.of<BouquetsCubit>(context).currentPage=1;
      BlocProvider.of<BouquetsCubit>(context).bouquets= [] ;
    });
    Future.delayed(Duration.zero, () {

      BlocProvider.of<BouquetsCubit>(context).getBouquetsInformation();
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
      if (BlocProvider.of<BouquetsCubit>(context).currentPage <
          BlocProvider.of<BouquetsCubit>(context).numberOfPages) {
        BlocProvider.of<BouquetsCubit>(context).currentPage += 1;

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
    await BlocProvider.of<BouquetsCubit>(context).getBouquetsInformation().then((value) {
      setState(() {
        isLoading=false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BouquetsCubit, BouquetsState>(
      listener: (context, state) {
        if (state is FailureBouquets) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return  ListView.separated(
                controller: _scrollController,
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 25,
                  );
                },
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.04),
                itemCount:
                    BlocProvider.of<BouquetsCubit>(context).bouquets.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index <
                      BlocProvider.of<BouquetsCubit>(context).bouquets.length) {
                    return  BlocProvider.of<BouquetsCubit>(context).bouquets.isEmpty
                        ? Center(
                        child: Text(
                          tr(StringConstants.thereIsNoData),
                          style: TextStyle(fontSize: 20, color: MyColors.grayText),
                        ))
                        :Container(
                      decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: MediaQuery.of(context).size.height * 0.27,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.0389),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      placeholder: (c, x) {
                                        return const SizedBox();
                                      },
                                      errorWidget: (c, s, e) {
                                        return const Icon(Icons.error);
                                      },
                                      imageUrl: BlocProvider.of<BouquetsCubit>(
                                              context)
                                          .bouquets[index]
                                          .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    width: MediaQuery.of(context).size.width,
                                    color: MyColors.myYellow,
                                    child: Text(
                                      BlocProvider.of<BouquetsCubit>(context)
                                              .bouquets[index]
                                              .price
                                              .toString() +
                                          "  ${tr(StringConstants.SAR)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: MyColors.myWhite,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    context.locale == const Locale("en")
                                        ? parseHtmlString(
                                            BlocProvider.of<BouquetsCubit>(
                                                    context)
                                                .bouquets[index]
                                                .nameEn)
                                        : parseHtmlString(
                                            BlocProvider.of<BouquetsCubit>(
                                                    context)
                                                .bouquets[index]
                                                .name),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      context.locale == const Locale("en")
                                          ? parseHtmlString(
                                              BlocProvider.of<BouquetsCubit>(
                                                      context)
                                                  .bouquets[index]
                                                  .descriptionEn)
                                          : parseHtmlString(
                                              BlocProvider.of<BouquetsCubit>(
                                                      context)
                                                  .bouquets[index]
                                                  .description),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: MyColors.primaryColor),
                                    ),
                                  ),
                                ),
                                ElevatedButtonTemplate(
                                    buttonText: tr(StringConstants.orderItNow),
                                    buttonColor: MyColors.primaryColor,
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return RequestBouquet(
                                          model: BlocProvider.of<BouquetsCubit>(
                                                  context)
                                              .bouquets[index],
                                        );
                                      }));
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return BlocProvider.of<BouquetsCubit>(context)
                                .currentPage <
                            BlocProvider.of<BouquetsCubit>(context)
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
                });
      },
    );
  }
}
