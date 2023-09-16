import 'package:easy_localization/easy_localization.dart';
import '/business_logic/questions_cubit/questions_cubit.dart';
import '/business_logic/questions_cubit/questions_states.dart';
import '/peresentation/screens/frequentaly_asked_questions/expansion_tile_template.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';

class FreqAskedQuestionsScreen extends StatelessWidget {
  const FreqAskedQuestionsScreen({Key? key}) : super(key: key);
  static const String id = 'freqAskedQuestionsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorWhite,
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tr(StringConstants.freqAskedQuestions),
              style: const TextStyle(
                  color: MyColors.primaryColor, fontSize: 20),
            ),
            Image.asset(
              ImageConstants.rectangleDesign,
              width: 23,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: OfflineBuilder(
                connectivityBuilder: (BuildContext ctx,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return const CustomFreqAsked();
                    // widget with initState   -->   apis
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

class CustomFreqAsked extends StatefulWidget {
  const CustomFreqAsked({Key? key}) : super(key: key);

  @override
  State<CustomFreqAsked> createState() => _CustomFreqAskedState();
}

class _CustomFreqAskedState extends State<CustomFreqAsked> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      BlocProvider.of<QuestionsCubit>(context).getQuestions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsStates>(
      listener: (ctx, states) {},
      builder: (ctx, states) {
        return states is GetQuestionsLoading
            ? const CircleLoadingByLottie()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    BlocProvider.of<QuestionsCubit>(context).questions.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTileTemplate(
                      answer: context.locale == const Locale("en")
                          ? parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .questions[index]
                                  .contentEnglish)
                          : parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .questions[index]
                                  .contentArabic),
                      questionTitle: context.locale == const Locale("en")
                          ? parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .questions[index]
                                  .titleEnglish)
                          : parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .questions[index]
                                  .titleArabic),
                    ),
                  );
                });
      },
    );
  }
}

String parseHtmlString(String htmlString) {
  // Remove HTML tags from the string using regex
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  String htmlString2 = htmlString.replaceAll(exp, '');

  String html3 = htmlString2.replaceAll("&nbsp;", "");
  String html4 = html3.replaceAll("&amp;", "");
  return html4;
}
