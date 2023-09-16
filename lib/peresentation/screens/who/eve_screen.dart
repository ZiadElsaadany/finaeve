import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/questions_cubit/questions_cubit.dart';
import '/business_logic/questions_cubit/questions_states.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/go_to_album.dart';

class EveScreen extends StatelessWidget {
  const EveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext ctx,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return const CustomEveScreen();
// widget with initState   -->   apis
            } else {
              return child;
            }
          },
          child: NoInternetWidget(
            txt: tr(StringConstants.noInternet),
          ),
        ));
  }
}

class TitleAndDesc extends StatelessWidget {
  const TitleAndDesc(
      {Key? key, required this.img, required this.title, required this.desc})
      : super(key: key);

  final String img;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: MyColors.myYellow,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (ctx, s) {
                      return const SizedBox();
                    },
                    errorWidget: (c, s, d) {
                      return const Icon(Icons.error);
                    },
                  ),
                ))),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold
                  )),
              Text(
                desc,
                style: const TextStyle(
                    fontSize: 12,
                    color: MyColors.grayText
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomEveScreen extends StatefulWidget {
  const CustomEveScreen({Key? key}) : super(key: key);

  @override
  State<CustomEveScreen> createState() => _CustomEveScreenState();
}

class _CustomEveScreenState extends State<CustomEveScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<QuestionsCubit>(context).getEveDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetEveLoading
            ? const CircleLoadingByLottie()
            : ListView(
                children: [
                  CachedNetworkImage(
                    imageUrl: BlocProvider.of<QuestionsCubit>(context)
                            .eve?[0]
                            .image ??
                        "",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const SizedBox(),
                    errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Icon(Icons.error)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.locale == const Locale("en")
                              ? parseHtmlString(
                                  BlocProvider.of<QuestionsCubit>(context)
                                          .eve?[0]
                                          .titleEnglish ??
                                      "")
                              : parseHtmlString(
                                  BlocProvider.of<QuestionsCubit>(context)
                                          .eve?[0]
                                          .titleArabic ??
                                      ""),
                          style: const TextStyle(
                              fontSize: 22, color: MyColors.primaryColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            context.locale == const Locale("en")
                                ? parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                            .eve?[0]
                                            .textEnglish ??
                                        "")
                                : parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                            .eve?[0]
                                            .textArabic ??
                                        ""),
                            style: GoogleFonts.cairo(fontSize: 16)),
                        Row(
                          children: [
                            Expanded(
                              child: TitleAndDesc(
                                  img: BlocProvider.of<QuestionsCubit>(context)
                                          .eve?[1]
                                          .image ??
                                      "",
                                  title: context.locale == const Locale("ar")
                                      ? parseHtmlString(
                                          BlocProvider.of<QuestionsCubit>(context)
                                                  .eve?[1]
                                                  .titleArabic ??
                                              "")
                                      : parseHtmlString(
                                          BlocProvider.of<QuestionsCubit>(context)
                                                  .eve?[1]
                                                  .titleEnglish ??
                                              ""),
                                  desc: context.locale == const Locale("ar")
                                      ? parseHtmlString(
                                          BlocProvider.of<QuestionsCubit>(context).eve?[1].textArabic ?? "")
                                      : parseHtmlString(BlocProvider.of<QuestionsCubit>(context).eve?[1].textEnglish ?? "")),
                            ),
                            Expanded(
                              child: TitleAndDesc(
                                img: BlocProvider.of<QuestionsCubit>(context)
                                        .eve?[2]
                                        .image ??
                                    "",
                                title: parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                            .eve?[2]
                                            .titleArabic ??
                                        ""),
                                desc: parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                            .eve?[2]
                                            .textArabic ??
                                        ""),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: MyColors.myYellow,
                                    borderRadius: BorderRadius.circular(20)),
                                child: CachedNetworkImage(
                                  height: MediaQuery.of(context).size.height*0.065,
                                  imageUrl:
                                      BlocProvider.of<QuestionsCubit>(context)
                                              .eve?[3]
                                              .image ??
                                          "",
                                  placeholder: (ctx, s) {
                                    return const SizedBox();
                                  },
                                  errorWidget: (c, s, d) {
                                    return const Icon(Icons.error);
                                  },
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      context.locale == const Locale("en")
                                          ? parseHtmlString(
                                              BlocProvider.of<QuestionsCubit>(
                                                          context)
                                                      .eve?[3]
                                                      .titleEnglish ??
                                                  "")
                                          : parseHtmlString(
                                              BlocProvider.of<QuestionsCubit>(
                                                          context)
                                                      .eve?[3]
                                                      .titleArabic ??
                                                  ""),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold
                                      )),
                                  Text(
                                    context.locale == const Locale("en")
                                        ? parseHtmlString(
                                            BlocProvider.of<QuestionsCubit>(
                                                        context)
                                                    .eve?[3]
                                                    .textEnglish ??
                                                "")
                                        : parseHtmlString(
                                            BlocProvider.of<QuestionsCubit>(
                                                        context)
                                                    .eve?[3]
                                                    .textArabic ??
                                                ""),
                                    style:const TextStyle(
                                      fontSize: 12,
                                      color: MyColors.grayText
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const RequestAlbumImage(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              );
      },
    );
  }
}
