import 'package:easy_localization/easy_localization.dart';
import '/business_logic/questions_cubit/questions_cubit.dart';
import '/business_logic/questions_cubit/questions_states.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/screens/what_say_about/textDetails.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';
import 'container_template.dart';

class WhatAllSayScreen extends StatelessWidget {
  const WhatAllSayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: OfflineBuilder(
                connectivityBuilder: (BuildContext ctx,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  if (connected) {
                    return const CustomWhatSay();
                  } else {
                    return child;
                  }
                },
                child: NoInternetWidget(
                  txt: tr(StringConstants.noInternet),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomWhatSay extends StatefulWidget {
  const CustomWhatSay({Key? key}) : super(key: key);

  @override
  State<CustomWhatSay> createState() => _CustomWhatSayState();
}

class _CustomWhatSayState extends State<CustomWhatSay> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<QuestionsCubit>(context).getWhatSay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetWhatSayLoading
            ? const CircleLoadingByLottie()
            : ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                          child: TextSayDetailsScreen(
                            title: context.locale == const Locale("en")
                                ? parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                        .whatSay[index]
                                        .textEnglish)
                                : parseHtmlString(
                                    BlocProvider.of<QuestionsCubit>(context)
                                        .whatSay[index]
                                        .textArabic),
                            name: BlocProvider.of<QuestionsCubit>(context)
                                .whatSay[index]
                                .name,
                            position: BlocProvider.of<QuestionsCubit>(context)
                                .whatSay[index]
                                .position,
                          ),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(seconds: 1),
                          reverseDuration:
                              const Duration(milliseconds: 500)));
                    },
                    child: ContainerWhatSayTemplate(
                        txt1: context.locale == const Locale("en")
                            ? parseHtmlString(
                            BlocProvider.of<QuestionsCubit>(context)
                                .whatSay[index]
                                .textEnglish)
                            : parseHtmlString(
                            BlocProvider.of<QuestionsCubit>(context)
                                .whatSay[index]
                                .textArabic),
                        txt2: BlocProvider.of<QuestionsCubit>(context)
                            .whatSay[index]
                            .name,
                        txt3: BlocProvider.of<QuestionsCubit>(context)
                            .whatSay[index]
                            .position),
                  );
                },
                itemCount:
                    BlocProvider.of<QuestionsCubit>(context).whatSay.length,
              );
      },
    );
  }
}
