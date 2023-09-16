import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '/peresentation/widgets/album_order_widgets/text_align.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/no_internet_widget.dart';
import '/peresentation/widgets/shared_widgets/text_input_template.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../models/list_models.dart';
import 'drop_down_button.dart';

class SpecificationDetails extends StatefulWidget {
  const SpecificationDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecificationDetails> createState() => _SpecificationDetailsState();
}

class _SpecificationDetailsState extends State<SpecificationDetails> {
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is ListsLoading
            ? const CircleLoadingByLottie()
            : state is ListsFailure ?

        NoInternetWidget(
          txt: state.message,

        ) : Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04,
            ),
            TextAlignForRequestAlbum(
                title: tr(StringConstants.theSizes)),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
            ),
            const SizesDropDownWidgetForSizesScreen(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
            ),

            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint &&
                BlocProvider
                    .of<ListsCubit>(context)
                    .currentSizeForPrintAlbum
                    ?.id == -1 ?
            TextAlignForRequestAlbum(
                color: Colors.red,
                title: tr(StringConstants.noSize)) : const SizedBox(),

            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),


            const BoxDropDownMenuForAlbumWithPrint(),
            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint && BlocProvider
                .of<ListsCubit>(context)
                .boxYesOrNoAlbumWithPrint
                ?.id == "" ?
            TextAlignForRequestAlbum(
                color: Colors.red,

                title: tr(StringConstants.noBox)) : const SizedBox(),


            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),
            const ExtensionDropDownMenuForAlbumWithPrint(),

            ///extension
            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint && BlocProvider
                .of<ListsCubit>(context)
                .withExtensionOrNotForWithPrint
                ?.id == "" ?

            TextAlignForRequestAlbum(
                color: Colors.red,

                title: tr(StringConstants.nowithExtension)) : const SizedBox(),


            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
            ),


            BlocProvider
                .of<ListsCubit>(context)
                .withExtensionOrNotForWithPrint
                ?.id ==
                "1"
                ? Column(
              children: [
                WithExtensionSelectedItems(),
                BlocProvider
                    .of<ListsCubit>(context)
                    .miniForAlbumWithPrint
                    .isEmpty ?
                TextAlignForRequestAlbum(
                    color: Colors.red,

                    title: tr(StringConstants.noExtension)) : const SizedBox(),
              ],
            )
                : const SizedBox(),


            /// images for box
            if (BlocProvider
                .of<ListsCubit>(context)
                .boxYesOrNoAlbumWithPrint
                ?.id ==
                "1") const ImagesBoxForAlbumWithPrint() else
              const SizedBox(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),


            /// pages
            const PagesForAlbumWithPrint(),

            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint && BlocProvider
                .of<ListsCubit>(context)
                .pagesForAlbumWithPrint
                ?.id == "" ?
            TextAlignForRequestAlbum(
                color: Colors.red,

                title: tr(StringConstants.noPages)) : const SizedBox(),

            /// process or not
            ///
            ///
            ///
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),
            const ProcessOrNotForAlbumWithPrint(),

            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint && BlocProvider
                .of<ListsCubit>(context)
                .withProcessOrNotForAlbumWithPrint
                ?.id == "" ?
            TextAlignForRequestAlbum(
                color: Colors.red,

                title: tr(StringConstants.noWithProcess)) : const SizedBox(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),

            //design or notes
            context
                .read<ListsCubit>()
                .withProcessOrNotForAlbumWithPrint
                ?.id == "1"
                ? Column(
              children: [
                TextInputTemplate(
                    onChanged: (value) {
                      BlocProvider.of<ListsCubit>(context)
                          .setNotesForDesignForAlbumWithPrint(value);
                    },
                    initialValue: BlocProvider
                        .of<ListsCubit>(context)
                        .notesForDesignForAlbumWithPrint,
                    headerTxt: tr(StringConstants.editNotes),
                    hintText: tr(StringConstants.notes)),
                // BlocProvider
                //     .of<ListsCubit>(context)
                //     .emptyOrNotPage1InAlbumWithPrint && BlocProvider
                //     .of<ListsCubit>(context)
                //     .notesForDesignForAlbumWithPrint
                //     .isEmpty ?
                // TextAlignForRequestAlbum(
                //     color: Colors.red,
                //
                //     title: tr(StringConstants.noNotes)) : const SizedBox()
              ],
            )
                : context
                .read<ListsCubit>()
                .withProcessOrNotForAlbumWithPrint
                ?.id == "0" ?
            Column(
              children: [
                DropDownButtonTemplate(
                  text: tr(StringConstants.pagesDesigner),
                  items: context
                      .read<ListsCubit>()
                      .listDesignOrNotForAlbumWithPrint ??
                      [],
                  value: context
                      .read<ListsCubit>()
                      .withDesignForAlbumWithPrint
                      ?.name,
                  onChanged: (value) {
                    BlocProvider.of<ListsCubit>(context)
                        .changeDesignOrNotForAlbumPrint(value!);
                    BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                  },
                ),
                BlocProvider
                    .of<ListsCubit>(context)
                    .emptyOrNotPage1InAlbumWithPrint==false && BlocProvider
                    .of<ListsCubit>(context)
                    .withProcessOrNotForAlbumWithPrint
                    ?.id != "" ? const SizedBox():
                TextAlignForRequestAlbum(
                    color: Colors.red,

                    title: tr(StringConstants.noWithDesign))
              ],
            ) : const SizedBox(),

            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),
          ],
        );
      },
    );
  }
}


class NextFormPage1FromAlbumWithPrint extends StatelessWidget {
  const NextFormPage1FromAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return MaterialButton(
          textColor: MyColors.myWhite,
          color: MyColors.primaryColor,
          onPressed: () {
            if (BlocProvider
                .of<ListsCubit>(context)
                .currentSizeForPrintAlbum!
                .id != -1
                && BlocProvider
                    .of<ListsCubit>(context)
                    .boxYesOrNoAlbumWithPrint!
                    .id != "" &&
                (
                    BlocProvider
                        .of<ListsCubit>(context)
                        .withExtensionOrNotForWithPrint!
                        .id == "0"
                        || BlocProvider
                        .of<ListsCubit>(context)
                        .withExtensionOrNotForWithPrint!
                        .id == "1" &&
                        BlocProvider
                            .of<ListsCubit>(context)
                            .miniForAlbumWithPrint
                            .isNotEmpty
                )
                && BlocProvider
                    .of<ListsCubit>(context)
                    .pagesForAlbumWithPrint!
                    .id != "" &&
                BlocProvider
                    .of<ListsCubit>(context)
                    .withProcessOrNotForAlbumWithPrint!
                    .id != "" &&

                (BlocProvider
                    .of<ListsCubit>(context)
                    .withProcessOrNotForAlbumWithPrint!
                    .id == "0" &&
                    BlocProvider
                        .of<ListsCubit>(context)
                        .withDesignForAlbumWithPrint!
                        .id != ""
                    || BlocProvider
                        .of<ListsCubit>(context)
                        .withProcessOrNotForAlbumWithPrint!
                        .id == "1" 
                ) && (
                BlocProvider
                    .of<ListsCubit>(context)
                    .boxYesOrNoAlbumWithPrint!
                    .id == "0" ||
                    BlocProvider
                        .of<ListsCubit>(context)
                        .boxYesOrNoAlbumWithPrint!
                        .id == "1" &&
                        BlocProvider
                            .of<ListsCubit>(context)
                            .modelImageForWithPrint != null ||
                    BlocProvider
                        .of<ListsCubit>(context)
                        .uploadAnotherModelOfPHOTOForAlbumWithPrint != null
            )
            ) {
              BlocProvider.of<ListsCubit>(context)
                  .updateEmptyOrNotPage1InAlbumWithPrint(b: false);
              print("done Album 1 ");
              BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .plusIndexOfAlbumPrint();
            } else {
              BlocProvider.of<ListsCubit>(context)
                  .updateEmptyOrNotPage1InAlbumWithPrint(b: true);
              print(
                  BlocProvider
                      .of<ListsCubit>(context)
                      .emptyOrNotPage1InAlbumWithPrint
                      .toString());

              debugPrint("error");
            }
          }
          ,
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          child: Text(tr(StringConstants.theNext)),
        );
      },
    );
  }
}


//SizesDropDownWidgetForSizesScreen
class SizesDropDownWidgetForSizesScreen extends StatelessWidget {
  const SizesDropDownWidgetForSizesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyColors.myGray),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: [
              SvgPicture.asset(PhotosConstants.albumIconG),
              // Your desired icon
              const SizedBox(width: 8.0),
              // Space between icon and label
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    // To take all possible horizontal space
                    value: context.locale == const Locale("en")
                        ? BlocProvider
                        .of<ListsCubit>(context)
                        .currentSizeForPrintAlbum
                        ?.nameEng ??
                        ""
                        : BlocProvider
                        .of<ListsCubit>(context)
                        .currentSizeForPrintAlbum
                        ?.name ??
                        "",
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCurrentSizeForAlbumWithPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                      debugPrint(
                          "id size Of AlbumWithPrint ${BlocProvider
                              .of<ListsCubit>(context)
                              .currentSizeForPrintAlbum
                              ?.id ?? ""}");
                    },

                    items: List<AlbumSize>.from(context
                        .read<ListsCubit>()
                        .listOfCurrentSizeForPrintAlbum ??
                        []
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: context.locale == const Locale("en")
                              ? item.nameEng
                              : item.name,
                          child: Text(
                            context.locale == const Locale("en")
                                ? item.nameEng
                                : item.name,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                              color: MyColors.myBlack,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ).toList() ??
                        [],
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


//BoxDropDownMenuForAlbumWithPrint
class BoxDropDownMenuForAlbumWithPrint extends StatelessWidget {
  const BoxDropDownMenuForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DropDownButtonTemplate(
          items: context
              .read<ListsCubit>()
              .listBoxOrNotForAlbumWithPrint ?? [],
          text: tr(StringConstants.theBox),
          value:
          context
              .read<ListsCubit>()
              .boxYesOrNoAlbumWithPrint
              ?.name ?? "",
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeBoxYesOrNoForWithPrint(value!);

            debugPrint(
                "id size Of AlbumWithPrint ${BlocProvider
                    .of<ListsCubit>(context)
                    .boxYesOrNoAlbumWithPrint
                    ?.id ?? ""}");
            if (BlocProvider
                .of<ListsCubit>(context)
                .boxYesOrNoAlbumWithPrint
                ?.id ==
                "0") {
              BlocProvider.of<ListsCubit>(context)
                  .makeChangeImageModelEqualNullForAlbumWithPrint();
            }
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);
          },
        );
      },
    );
  }
}

//extensions
class ExtensionDropDownMenuForAlbumWithPrint extends StatelessWidget {
  const ExtensionDropDownMenuForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropDownButtonTemplate(
          text: tr(StringConstants.extension_type),
          items: BlocProvider
              .of<ListsCubit>(context)
              .listExtensionsOrNotForAlbumWithPrint ??
              [],
          value:
          context
              .read<ListsCubit>()
              .withExtensionOrNotForWithPrint
              ?.name ??
              "",
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeExtensionsYesOrNoForWithPrint(value!);
            debugPrint(
                "extension size Of AlbumWithPrint ${BlocProvider.of<ListsCubit>(
                    context)}");
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);
          },
        );
      },
    );
  }
}

class WithExtensionSelectedItems extends StatefulWidget {
  const WithExtensionSelectedItems({Key? key}) : super(key: key);

  @override
  State<WithExtensionSelectedItems> createState() =>
      _WithExtensionSelectedItemsState();
}

class _WithExtensionSelectedItemsState
    extends State<WithExtensionSelectedItems> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.05,
          child: ListView.separated(
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                width: 10,
              );
            },
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider
                          .of<ListsCubit>(context)
                          .lstBoolForWithAlbum[index] = !BlocProvider
                          .of<ListsCubit>(context)
                          .lstBoolForWithAlbum[index];
                      BlocProvider.of<ListsCubit>(context).updateMini(
                          BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == true
                              && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[1] == false &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[2] == false
                              ?
                          "4" : BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == true
                              && BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[1] == true &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[2] == false
                              ? "4,3" :
                          BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == true
                              && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[1] == true &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[2] == true ? "4,3,2" :

                          BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == false
                              && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[1] == true &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[2] == false
                              ?
                          "3" : BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == true
                              &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[0] == true
                              && BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[1] == false &&
                              BlocProvider
                                  .of<ListsCubit>(context)
                                  .lstBoolForWithAlbum[2] == true ? "4,2" :
                          BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == false && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[1] == false && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[2] == true ?
                          "2" :
                          BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[0] == false && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[1] == true && BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[2] == true ?
                          "3,2" : ""
                      );

                      if (BlocProvider
                          .of<ListsCubit>(context)
                          .boxYesOrNoAlbumWithPrint
                          ?.id == "1") {
                        BlocProvider.of<ListsCubit>(context)
                            .getImagesFromExtensionLikeMiniFromApi(
                            extension_type_id:
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == true
                                && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[1] == false &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[2] == false
                                ?
                            "4" : BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == true
                                && BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[1] == true &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[2] == false
                                ? "4,3" :
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == true
                                && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[1] == true &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[2] == true ? "4,3,2" :

                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == false
                                && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[1] == true &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[2] == false
                                ?
                            "3" : BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == true
                                &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[0] == true
                                && BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[1] == false &&
                                BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstBoolForWithAlbum[2] == true ? "4,2" :
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == false && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[1] == false && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[2] == true ?
                            "2" :
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[0] == false && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[1] == true && BlocProvider
                                .of<ListsCubit>(context)
                                .lstBoolForWithAlbum[2] == true ?
                            "3,2" : ""


                        );
                        BlocProvider.of<ListsCubit>(context).funGetPrice(
                            context);
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColors.myGray, width: 2),
                          color: BlocProvider
                              .of<ListsCubit>(context)
                              .lstBoolForWithAlbum[index] == true
                              ? MyColors.primaryColor
                              : Colors.transparent),
                    ),
                  ),
                  SizedBox(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.01),
                  Text(

                    /// localization here fot text   name_en
                    context.locale == const Locale("en")
                        ? BlocProvider
                        .of<ListsCubit>(context)
                        .lstExtensionWithPrint![index]
                        .nameEng
                        : BlocProvider
                        .of<ListsCubit>(context)
                        .lstExtensionWithPrint![index]
                        .name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(
                      color: MyColors.myBlack,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            },
            itemCount: BlocProvider
                .of<ListsCubit>(context)
                .lstBoolForWithAlbum
                .length,
          ),
        );
      },
    );
  }
}


class ImagesBoxForAlbumWithPrint extends StatefulWidget {
  const ImagesBoxForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  State<ImagesBoxForAlbumWithPrint> createState() => _ImagesBoxForAlbumWithPrintState();
}

class _ImagesBoxForAlbumWithPrintState extends State<ImagesBoxForAlbumWithPrint> {
  bool another  =false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),
            TextAlignForRequestAlbum(
                title: tr(StringConstants.chooseTheModel)),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.015,
            ),

            state is GetImagesFromExtensionLikeMiniFromApiLoadingState ?
            const Center(child: CircleLoadingByLottie())
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),

              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {

                      another = false;
                    });
                    BlocProvider.of<ListsCubit>(context)
                        .changeModelImagesForAlbumWithPrint(
                        BlocProvider
                            .of<ListsCubit>(context)
                            .lstModelImageForWithPrint![index].id
                    );

                    BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                    debugPrint(BlocProvider
                        .of<ListsCubit>(context)
                        .modelImageForWithPrint!
                        .imageUrl);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:

                        BlocProvider
                            .of<ListsCubit>(context)
                            .modelImageForWithPrint
                            ?.id ==
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstModelImageForWithPrint
                                ?.elementAt(index)
                                .id
                            ? MyColors.primaryColor : Colors.transparent
                            ,
                            width: 2
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        )),
                    // padding: EdgeInsets.symmetric(
                    //     vertical: MediaQuery.of(context).size.height * 0.01,
                    //     horizontal: MediaQuery.of(context).size.width * 0.005),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                            BlocProvider
                                .of<ListsCubit>(context)
                                .lstModelImageForWithPrint?[index].imageUrl ??
                                "",
                            placeholder: (c, d) {
                              return const SizedBox();
                            },
                            errorWidget: (c, x, d) {
                              return const Icon(Icons.error);
                            },
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(tr(StringConstants.albumName),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              Expanded(
                                child: Text(BlocProvider
                                    .of<ListsCubit>(context)
                                    .lstModelImageForWithPrint?[index].name ??
                                    "",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 14
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                  ),
                );
              },
              itemCount: BlocProvider
                  .of<ListsCubit>(context)
                  .lstModelImageForWithPrint
                  ?.length ?? 0,
            ),

            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint("clicked");
                      setState(() {
                        another = !another;
                      });
                      BlocProvider.of<ListsCubit>(context)
                          .makeChangeImageModelEqualNullForAlbumWithPrint();
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                          another ?
                          Border.all(color: MyColors.primaryColor,
                          width: 3
                          ):null,

                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          )), child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery
                              .of(context)
                              .size
                              .width * 0.055,vertical: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.lightGray
                          ),
                          child: SvgPicture.asset(PhotosConstants.endOderIconG),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        Text(
                          tr(StringConstants.other),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: MyColors.myBlack,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(
              height:
              MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
    //
 another ?    Column(
        children: [
          Text(
            tr(
              StringConstants.uploadAnotherAlbum,
            ),
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge!
                .copyWith(
              color: MyColors.myBlack,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height:
            MediaQuery
                .of(context)
                .size
                .height * 0.02,
          ),
          BlocProvider
              .of<ListsCubit>(context)
              .uploadAnotherModelOfPHOTOForAlbumWithPrint !=
              null
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:
            MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  child: Stack(
                    alignment:
                    AlignmentDirectional
                        .topEnd,
                    children: [
                      Image.file(
                        BlocProvider
                            .of<ListsCubit>(
                            context)
                            .uploadAnotherModelOfPHOTOForAlbumWithPrint
                        as File,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets
                            .all(8.0),
                        child:
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<
                                ListsCubit>(
                                context)
                                .removeUploadAnotherModelOfPHOTOForAlbumWithPrint();
                            BlocProvider.of<ListsCubit>(context).funGetPrice(
                                context);
                            setState(() {

                            });
                          },
                          child:
                          const CircleAvatar(
                              backgroundColor:
                              Colors
                                  .red,
                              child:
                              Icon(
                                Icons
                                    .close,
                                color: Colors
                                    .white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
              : Container(
            padding: const EdgeInsets.symmetric(
                vertical: 3
            ),
            decoration: BoxDecoration(
                color: MyColors.myGray.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
              onTap: () async {
                XFile? result =
                await ImagePicker().pickImage(
                  source:ImageSource.gallery
                );

                if (result != null) {
                  BlocProvider.of<ListsCubit>(context)
                      .getImageFromGalleryForAlbumWithPrint(
                      File(
                          result.path));
                  // Update the UI to display the selected file
                }
                BlocProvider.of<ListsCubit>(context).funGetPrice(context);
              },

              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(PhotosConstants.uploadPhotoG),
                  const SizedBox(
                    height: 8,
                  ),

                ],
              ),
            ),
          )
        ],
      ) : SizedBox(),
            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint
                &&another && BlocProvider
            .of<ListsCubit>(context)
            .uploadAnotherModelOfPHOTOForAlbumWithPrint==null
                ?     TextAlignForRequestAlbum(
              title: tr(StringConstants.uploadAnotherAlbum),
              color: Colors.red,
            ) :
            BlocProvider
                .of<ListsCubit>(context)
                .emptyOrNotPage1InAlbumWithPrint
                &&another==false&&
        BlocProvider
            .of<ListsCubit>(context)
            .modelImageForWithPrint==null?
                   TextAlignForRequestAlbum(
        title: tr(StringConstants.noModel),
        color: Colors.red,
        )   : SizedBox()
          ],
        );
      },
    );
  }
}

class PagesForAlbumWithPrint extends StatelessWidget {
  const PagesForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DropDownButtonTemplate(
          items:
          context
              .read<ListsCubit>()
              .listOfPagesForAlbumWithPrint ?? [],
          text: tr(
            StringConstants.pagesNum,
          ),
          value: context
              .read<ListsCubit>()
              .pagesForAlbumWithPrint
              ?.name,
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changePagesWithAlbumPrint(value!);
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);
          },
        );
      },
    );
  }
}

class ProcessOrNotForAlbumWithPrint extends StatelessWidget {
  const ProcessOrNotForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DropDownButtonTemplate(
          text: tr(StringConstants.withOrWithoutEdit),
          items: context
              .read<ListsCubit>()
              .listProcessOrNotForAlbumWithPrint ??
              [],
          value: BlocProvider
              .of<ListsCubit>(context)
              .withProcessOrNotForAlbumWithPrint
              ?.name,
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeProcessOrNotForAlbumPrint(value!);
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);
          },
        );
      },
    );
  }
}
