import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/all_requests_cubit/all_request_cubit.dart';
import '/business_logic/all_requests_cubit/all_request_states.dart';
import '/peresentation/screens/all_requests/images_screen.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utilities/constants/colors.dart';
import 'all_requests_screen.dart';
import 'notes_image.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen(
      {Key? key, required this.num, required this.data, required this.status})
      : super(key: key);

  final int num;
  final String data;
  final String status;
  static const String id = "RequestDetailsScreen";

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<AllRequestCubit>(context)
          .showRequestDetails(id: widget.num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocConsumer<AllRequestCubit, AllRequestStates>(
          listener: (context, state) {
            if (state is FailureShowRequest) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red, content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return state is SuccessShowRequest
                ? Column(
                    children: [
                      ItemOfRequest(
                        date: widget.data,
                        number: widget.num,
                        status: widget.status,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          itemCount:
                              StringConstants.myListOfOrderDetails.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return index == 0
                                ? SizedBox()
                                : BlocProvider.of<AllRequestCubit>(context)
                                                .values[index]
                                                .toString() !=
                                            "null" &&
                                        BlocProvider.of<AllRequestCubit>(
                                                    context)
                                                .values[index]
                                                .toString() !=
                                            "0" &&
                                        BlocProvider.of<AllRequestCubit>(
                                                    context)
                                                .values[index]
                                                .toString() !=
                                            "لم يحدد" &&
                                        BlocProvider.of<AllRequestCubit>(
                                                    context)
                                                .values[index]
                                                .toString() !=
                                            "" &&
                                        BlocProvider.of<AllRequestCubit>(
                                                    context)
                                                .values[index]
                                                .toString() !=
                                            "لايوجد" &&
                                        BlocProvider.of<AllRequestCubit>(
                                                    context)
                                                .values[index]
                                                .toString() !=
                                            "غير محدد"
                                    ? CustomContainerForDetailsRequest(
                                        txt:
                                            "${StringConstants.myListOfOrderDetails[index]["title"]}     |    ${BlocProvider.of<AllRequestCubit>(context).values[index].toString()}",
                                      )
                                    : const SizedBox();
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocProvider.of<AllRequestCubit>(context)
                                  .showRequestModel!
                                  .albumImages!
                                  .length >
                              2
                          ? Row(
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: GestureDetector(
                                          onTap:  ( ) {
                                            Navigator.of(context).push(PageTransition(
                                              child: NotesScreenImage(
                                                imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![0].image,
                                                imgId: BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![0].id.toString(),
                                              ),
                                              type: PageTransitionType.bottomToTop,
                                              duration: const Duration(seconds: 1),
                                              reverseDuration: const Duration(milliseconds: 500),
                                            ));
                                          },
                                          child: CachedNetworkImage(
                                              placeholder: (C, x) {
                                                return const SizedBox();
                                              },
                                              errorWidget: (c, s, a) {
                                                return const Icon(Icons.error);
                                              },
                                              imageUrl: BlocProvider.of<
                                                      AllRequestCubit>(context)
                                                  .showRequestModel!
                                                  .albumImages![0]
                                                  .image),
                                        ))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: GestureDetector(
                                          onTap:  ( ) {
                                            Navigator.of(context).push(PageTransition(
                                              child: NotesScreenImage(
                                                imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![1].image,
                                                imgId: BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![1].id.toString(),
                                              ),
                                              type: PageTransitionType.bottomToTop,
                                              duration: const Duration(seconds: 1),
                                              reverseDuration: const Duration(milliseconds: 500),
                                            ));
                                          },
                                          child: CachedNetworkImage(
                                              placeholder: (C, x) {
                                                return const SizedBox();
                                              },
                                              errorWidget: (c, s, a) {
                                                return const Icon(Icons.error);
                                              },
                                              imageUrl: BlocProvider.of<
                                                      AllRequestCubit>(context)
                                                  .showRequestModel!
                                                  .albumImages![1]
                                                  .image),
                                        ))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: GestureDetector(
                                          onTap:  ( ) {
                                            Navigator.of(context).push(PageTransition(
                                              child: NotesScreenImage(
                                                imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![2].image,
                                                imgId: BlocProvider.of<AllRequestCubit>(context)
                                                    .showRequestModel!
                                                    .albumImages![2].id.toString(),
                                              ),
                                              type: PageTransitionType.bottomToTop,
                                              duration: const Duration(seconds: 1),
                                              reverseDuration: const Duration(milliseconds: 500),
                                            ));
                                          },
                                          child: CachedNetworkImage(
                                              placeholder: (C, x) {
                                                return const SizedBox();
                                              },
                                              errorWidget: (c, s, a) {
                                                return const Icon(Icons.error);
                                              },
                                              imageUrl: BlocProvider.of<
                                                      AllRequestCubit>(context)
                                                  .showRequestModel!
                                                  .albumImages![2]
                                                  .image),
                                        ))),
                              ],
                            )
                          : BlocProvider.of<AllRequestCubit>(context)
                                      .showRequestModel!
                                      .albumImages!
                                      .length ==
                                  2
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: GestureDetector(
                                              onTap:  ( ) {
                                                Navigator.of(context).push(PageTransition(
                                                  child: NotesScreenImage(
                                                    imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                        .showRequestModel!
                                                        .albumImages![0].image,
                                                    imgId: BlocProvider.of<AllRequestCubit>(context)
                                                        .showRequestModel!
                                                        .albumImages![0].id.toString(),
                                                  ),
                                                  type: PageTransitionType.bottomToTop,
                                                  duration: const Duration(seconds: 1),
                                                  reverseDuration: const Duration(milliseconds: 500),
                                                ));
                                              },
                                              child: CachedNetworkImage(
                                                  placeholder: (C, x) {
                                                    return const SizedBox();
                                                  },
                                                  errorWidget: (c, s, a) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                  imageUrl: BlocProvider.of<
                                                              AllRequestCubit>(
                                                          context)
                                                      .showRequestModel!
                                                      .albumImages![0]
                                                      .image),
                                            ))),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: GestureDetector(
                                              onTap:  ( ) {
                                                Navigator.of(context).push(PageTransition(
                                                  child: NotesScreenImage(
                                                    imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                        .showRequestModel!
                                                        .albumImages![1].image,
                                                    imgId: BlocProvider.of<AllRequestCubit>(context)
                                                        .showRequestModel!
                                                        .albumImages![1].id.toString(),
                                                  ),
                                                  type: PageTransitionType.bottomToTop,
                                                  duration: const Duration(seconds: 1),
                                                  reverseDuration: const Duration(milliseconds: 500),
                                                ));
                                              },
                                              child: CachedNetworkImage(
                                                  placeholder: (C, x) {
                                                    return const SizedBox();
                                                  },
                                                  errorWidget: (c, s, a) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                  imageUrl: BlocProvider.of<
                                                              AllRequestCubit>(
                                                          context)
                                                      .showRequestModel!
                                                      .albumImages![1]
                                                      .image),
                                            ))),
                                  ],
                                )
                              : BlocProvider.of<AllRequestCubit>(context)
                                          .showRequestModel!
                                          .albumImages!
                                          .length ==
                                      1
                                  ? Row(
                                      children: [
                                        Expanded(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: GestureDetector(
                                                  onTap:  ( ) {
                                                    Navigator.of(context).push(PageTransition(
                                                      child: NotesScreenImage(
                                                        imgUrl:BlocProvider.of<AllRequestCubit>(context)
                                                            .showRequestModel!
                                                            .albumImages![0].image,
                                                        imgId: BlocProvider.of<AllRequestCubit>(context)
                                                            .showRequestModel!
                                                            .albumImages![0].id.toString(),
                                                      ),
                                                      type: PageTransitionType.bottomToTop,
                                                      duration: const Duration(seconds: 1),
                                                      reverseDuration: const Duration(milliseconds: 500),
                                                    ));
                                                  },
                                                  child: CachedNetworkImage(
                                                      placeholder: (C, x) {
                                                        return const SizedBox();
                                                      },
                                                      errorWidget: (c, s, a) {
                                                        return const Icon(
                                                            Icons.error);
                                                      },
                                                      imageUrl: BlocProvider.of<
                                                                  AllRequestCubit>(
                                                              context)
                                                          .showRequestModel!
                                                          .albumImages![0]
                                                          .image),
                                                ))),
                                      ],
                                    )
                                  : BlocProvider.of<AllRequestCubit>(context)
                                          .showRequestModel!
                                          .albumImages!
                                          .isEmpty
                                      ? const SizedBox()
                                      : SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocProvider.of<AllRequestCubit>(context)
                              .showRequestModel!
                              .albumImages!
                              .isEmpty
                          ? const SizedBox()
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              minWidth: MediaQuery.of(context).size.width * 0.7,
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                  child: ImagesScreen(
                                    images: BlocProvider.of<AllRequestCubit>(
                                                context)
                                            .showRequestModel
                                            ?.albumImages ??
                                        [],
                                  ),
                                  type: PageTransitionType.bottomToTop,
                                  duration: const Duration(seconds: 1),
                                  reverseDuration:
                                      const Duration(milliseconds: 500),
                                ));
                              },
                              color: MyColors.myYellow,
                              child: Text(
                                tr(StringConstants.theAdditionalPhotos),
                                style: const TextStyle(
                                    color: MyColors.myWhite, fontSize: 16),
                              ),
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                    ],
                  )
                : const Center(child: CircleLoadingByLottie());
          },
        ),
      ),
    );
  }
}

class CustomContainerForDetailsRequest extends StatelessWidget {
  const CustomContainerForDetailsRequest({Key? key, required this.txt})
      : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.myGray.withOpacity(0.3),
          border: Border.all(
            color: MyColors.myGray,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        txt,
        style:
            TextStyle(color: MyColors.myBlack.withOpacity(0.5), fontSize: 16),
      ),
    );
  }
}
