import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/our_advantages/our_advantages_cubit.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/our_services/our_services_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../widgets/circle_lottie_loading.dart';

class OurAdvantagesItems extends StatefulWidget {
  const OurAdvantagesItems({Key? key}) : super(key: key);

  @override
  State<OurAdvantagesItems> createState() => _OurAdvantagesItemsState();
}

class _OurAdvantagesItemsState extends State<OurAdvantagesItems> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OurAdvantagesCubit, OurAdvantagesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is OurAdvantagesLoadingState
            ? const CircleLoadingByLottie()
            : Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 3),
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01,
                          vertical: MediaQuery.of(context).size.height * 0.007),
                      decoration: BoxDecoration(
                        color: MyColors.lightGray.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.03),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColors.myYellow),
                              child: CachedNetworkImage(
                                placeholder: (c, v) {
                                  return const SizedBox();
                                },
                                errorWidget: (c, x, s) {
                                  return const Icon(Icons.error);
                                },
                                fit: BoxFit.cover,
                                imageUrl:
                                    BlocProvider.of<OurAdvantagesCubit>(context)
                                        .ourAdvantageList[index]
                                        .image,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.locale == const Locale("en")
                                      ? parseHtmlString(
                                          BlocProvider.of<OurServicesCubit>(
                                                  context)
                                              .ourServices[index]
                                              .titleEn)
                                      : parseHtmlString(
                                          BlocProvider.of<OurAdvantagesCubit>(
                                                  context)
                                              .ourAdvantageList[index]
                                              .title),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: MyColors.primaryColor),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: BlocProvider.of<OurAdvantagesCubit>(context)
                      .ourAdvantageList
                      .length,
                ),
              );
      },
    );
  }
}
