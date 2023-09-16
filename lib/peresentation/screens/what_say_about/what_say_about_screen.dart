import 'package:easy_localization/easy_localization.dart';
import '/business_logic/questions_cubit/questions_cubit.dart';
import '/business_logic/questions_cubit/questions_states.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/screens/what_say_about/container_template.dart';
import '/peresentation/screens/what_say_about/textDetails.dart';
import '/peresentation/screens/what_say_about/what_say_all_screen.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/utilities/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';

class WhatSayScreen extends StatelessWidget {
  const WhatSayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(StringConstants.whatSay),
              textAlign: TextAlign.start,
              style:
                  const TextStyle(color: MyColors.primaryColor, fontSize: 20),
            ),
            Image.asset(
              ImageConstants.rectangleDesign,
              width: 23,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: OfflineBuilder(
                connectivityBuilder: (BuildContext ctx,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                    child: const WhatAllSayScreen(),
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(seconds: 1),
                    reverseDuration: const Duration(milliseconds: 500),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),

                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    context.locale == const Locale("en")
                        ? SvgPicture.asset(
                            PhotosConstants.arrowLeft,
                          )
                        : SvgPicture.asset(
                            PhotosConstants.arrowRight,
                            alignment: Alignment.centerRight,
                          ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Text(
                      tr(StringConstants.showMore),
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: MyColors.colorWhite,
                                fontSize: 18,
                              ),
                    ),
                  ],
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
            : ListView.builder(
            itemCount: BlocProvider.of<QuestionsCubit>(context).whatSay.length>=3 ?
            3 :  BlocProvider.of<QuestionsCubit>(context).whatSay.length
            ,
            itemBuilder: (ctx,index) {
              return



                GestureDetector(
                  onTap:  ( ) {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return TextSayDetailsScreen(
                          title: context.locale == const Locale("en")
                              ? parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .whatSay[index]
                                  .textEnglish)
                              : parseHtmlString(
                              BlocProvider.of<QuestionsCubit>(context)
                                  .whatSay[index]
                                  .textArabic),
                          name:  BlocProvider.of<QuestionsCubit>(context)
                              .whatSay[index]
                              .name,
                          position: BlocProvider.of<QuestionsCubit>(context)
                              .whatSay[index]
                              .position


                      ) ;
                    }) );
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

        });
      },
    );
  }
}
