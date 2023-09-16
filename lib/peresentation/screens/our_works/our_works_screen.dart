
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/works_cubit/works_cubit.dart';
import '/business_logic/works_cubit/works_states.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../widgets/no_internet_widget.dart';
import 'my_services_screen.dart';

class OurWorksScreen extends StatelessWidget {
  const OurWorksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const CustomOurWorksScreen();
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

class CustomOurWorksScreen extends StatefulWidget {
  const CustomOurWorksScreen({Key? key}) : super(key: key);

  @override
  State<CustomOurWorksScreen> createState() => _CustomOurWorksScreenState();
}

class _CustomOurWorksScreenState extends State<CustomOurWorksScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorksCubit>(context).restartWorksItemIndex();

    BlocProvider.of<WorksCubit>(context).getWorksDepartments().then((value) {
      BlocProvider.of<WorksCubit>(context).getWorks(
          id: BlocProvider.of<WorksCubit>(context).worksDepartments[0].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorksCubit, WorksStates>(
        listener: (ctx, state) {},
        builder: (context, state) {
          return Center(
            child: state is WorksDepartmentLoading || state is WorksLoading
                ? const CircleLoadingByLottie()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(StringConstants.works),
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
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [

                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<WorksCubit>(context)
                                              .changeWorksItemIndex(
                                                  index: index);
                                        },
                                        child: WorksDesignContainer(
                                          index: index,
                                          txt: context.locale ==
                                                  const Locale("en")
                                              ? parseHtmlString(
                                                  BlocProvider.of<WorksCubit>(
                                                          context)
                                                      .worksDepartments[index]
                                                      .nameEn)
                                              : parseHtmlString(
                                                  BlocProvider.of<WorksCubit>(
                                                          context)
                                                      .worksDepartments[index]
                                                      .name),
                                        ));
                                  },
                                  itemCount:
                                      BlocProvider.of<WorksCubit>(context)
                                          .worksDepartments
                                          .length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GridView.builder(
                              itemCount: BlocProvider.of<WorksCubit>(context)
                                  .works
                                  .length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 3,
                                    mainAxisSpacing: 3
                                  ),
                              itemBuilder: (ctx, indx) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(PageTransition(
                                      child: MyServices(
                                        model:
                                            BlocProvider.of<WorksCubit>(context)
                                                .works[indx],
                                      ),
                                      type: PageTransitionType.bottomToTop,
                                      duration: const Duration(seconds: 1),
                                      reverseDuration:
                                          const Duration(milliseconds: 500),
                                    ));
                                  },
                                  child: ContainerForImageAndText(
                                    img: BlocProvider.of<WorksCubit>(context)
                                        .works[indx]
                                        .image,
                                    txt: context.locale==const Locale("en")?
                                    parseHtmlString(BlocProvider.of<WorksCubit>(context)
                                        .works[indx] .title):
                                    parseHtmlString(BlocProvider.of<WorksCubit>(context)
                                        .works[indx] .titleEn),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 20,),
                        // const RequestAlbumImage(),
                        // SizedBox(height: 10,),
                      ],
                    ),
                  ),
          );
        });
  }
}

class ContainerForImageAndText extends StatelessWidget {
  const ContainerForImageAndText(
      {Key? key, required this.img, required this.txt})
      : super(key: key);
  final String img;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: MyColors.myWhite),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                placeholder: (c,x) {
                  return const SizedBox();
                },
                errorWidget: (c,s,e) {
                  return const Icon(Icons.error);
                },
                imageUrl: img,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.13,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColors.colorWhite),
              child: Text(

                txt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, color: MyColors.primaryColor),
              ),
            )
          ],
        ));
  }
}

class WorksDesignContainer extends StatelessWidget {
  const WorksDesignContainer({Key? key, required this.index, required this.txt})
      : super(key: key);

  final int index;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.of<WorksCubit>(context).worksItemIndex == index
        ? Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              txt,
              style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
            ),
          )
        : Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: MyColors.myWhite,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              txt,
              style: const TextStyle(color: MyColors.myBlack, fontSize: 16),
            ));
  }
}
