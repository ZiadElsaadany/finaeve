import 'package:easy_localization/easy_localization.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../models/list_models.dart';
import '../../widgets/album_order_widgets/text_align.dart';

class AlbumDataScreen extends StatefulWidget {
  const AlbumDataScreen({Key? key}) : super(key: key);

  @override
  State<AlbumDataScreen> createState() => _AlbumDataScreenState();
}

class _AlbumDataScreenState extends State<AlbumDataScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.myWhite),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextAlignForRequestAlbum(
                      title: tr(StringConstants.theNewlywedsName)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextFormField(
                    initialValue: BlocProvider.of<ListsCubit>(context).nameOfCouplesForAlbumPrint,
                    onChanged: (v) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCoupleNamesForAlbumPrint(v);

                    },
                    cursorColor: MyColors.primaryColor,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(PhotosConstants.albumIconG),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.myGray)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.myGray)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.myGray))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  BlocProvider.of<ListsCubit>(context)
                      .emptyOrNotPage3InAlbumWithPrint &&    BlocProvider.of<ListsCubit>(context)
                          .nameOfCouplesForAlbumPrint
                          .isEmpty
                      ? TextAlignForRequestAlbum(
                          color: Colors.red,
                          title: tr(StringConstants.noCouplesName))
                      : const SizedBox(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextAlignForRequestAlbum(
                      title: tr(StringConstants.wayOfWritingTheNames)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const WayOfWritingNamesForPrintAlbum(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (BlocProvider.of<ListsCubit>(context)
                          .drillingTypeForAlbumWithPrint!
                          .id ==
                      -1 &&    BlocProvider.of<ListsCubit>(context)
                      .emptyOrNotPage3InAlbumWithPrint )
                    TextAlignForRequestAlbum(
                      title: tr(StringConstants.noWritingName),
                      color: Colors.red,
                    )
                  else
                    const SizedBox(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Card(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(StringConstants.dateOfTheOccasion),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: MyColors.grayText,
                                  fontSize: 14,
                                ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeHistoryOfAlbumWithPrint("1");
                                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: MyColors.myGray, width: 2),
                                        color: BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint?.id=="1"
                                            ? MyColors.primaryColor
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    tr(StringConstants.yes),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: MyColors.grayText,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeHistoryOfAlbumWithPrint("0");
                                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: MyColors.myGray, width: 2),
                                          color:  BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint?.id=="0"
                                              ? MyColors.primaryColor:Colors.transparent
                                              ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    tr(StringConstants.no),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: MyColors.grayText,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint?.id ==
                          "1"
                      ? Column(
                          children: [
                            TextAlignForRequestAlbum(
                                title: tr(StringConstants.dateOfCelebration)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              initialValue: BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithPrint,

                              cursorColor: MyColors.primaryColor,
                              onChanged: (v) {
                                BlocProvider.of<ListsCubit>(context)
                                    .changeHistoryDateForAlbumWithPrint(v);
                              },
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray))),
                            ),


                            BlocProvider.of<ListsCubit>(context)
                                .emptyOrNotPage3InAlbumWithPrint &&        BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithPrint.isEmpty?
        TextAlignForRequestAlbum(
          color: Colors.red,
        title: tr(StringConstants.noHistoryDate))

            :const SizedBox()
                          ],
                        )
                      : const SizedBox(),
                  Card(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(StringConstants.externalFamilyPhotos),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: MyColors.grayText,
                                  fontSize: 14,
                                ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeWithFamilyAlbumWithPrint("1");
                                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: MyColors.myGray, width: 2),
                                        color: BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint?.id=="1"
                                            ? MyColors.primaryColor
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    tr(StringConstants.yes),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: MyColors.grayText,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeWithFamilyAlbumWithPrint("0");

                                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: MyColors.myGray, width: 2),
                                          color: BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint?.id == "0"
                                              ? MyColors.primaryColor: Colors.transparent),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    tr(StringConstants.no),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: MyColors.grayText,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint?.id == "1"
                      ? Column(
                          children: [
                         TextAlignForRequestAlbum(title:  tr(StringConstants.numOfPhotos)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextFormField(
                              initialValue:  BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint,
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (c) {
                                BlocProvider.of<ListsCubit>(context)
                                    .changeNumOfPhotosForAlbumWithPrint(c);
                              },
                              onChanged: ( n) {
print(n);

                                 BlocProvider.of<ListsCubit>(context)
                                     .changeNumOfPhotosForAlbumWithPrint(n);
                                 BlocProvider.of<ListsCubit>(context).getAlbumPrice(
                                   context: context,
                                   id:BlocProvider.of<ListsCubit>(context).currentSizeForPrintAlbum?.id.toString() ?? "",
                                   //
                                   page:BlocProvider.of<ListsCubit>(context).pagesForAlbumWithPrint?.id ?? "",
                                   //
                                   box: BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithPrint?.id ?? "",
                                   //
                                   type: BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint?.id.toString() ?? "",
                                   orderType: (BlocProvider.of<AlbumDetailsRowCubit>(context)
                                       .indexOfSelectedRequestOfAlbum +
                                       1)
                                       .toString(),
                                   //
                                   drillingType: BlocProvider.of<ListsCubit>(context).drillingTypeForAlbumWithPrint?.id.toString() ?? "",
                                   //
                                   sideImage: BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint?.id.toString() ?? "",
                                   withProcess: BlocProvider.of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id ?? "",
                                   //
                                   withExtension: BlocProvider.of<ListsCubit>(context).withExtensionOrNotForWithPrint?.id ?? "",
                                   withDesign: BlocProvider.of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id=="0"?
                                   BlocProvider.of<ListsCubit>(context).withDesignForAlbumWithPrint?.id ?? "":"",
                                   sideImagePage:
                                   BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint?.id=="1" ?
                                   n:"",
                                   modelImage:
                                   BlocProvider.of<ListsCubit>(context). boxYesOrNoAlbumWithPrint!.id == "1" &&
                                       BlocProvider.of<ListsCubit>(context).modelImageForWithPrint != null
                                       ? BlocProvider.of<ListsCubit>(context).modelImageForWithPrint?.id.toString() ?? ""
                                       : "",
                                 );

                              },

                              cursorColor: MyColors.primaryColor,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColors.myGray))),
                            ),

                            BlocProvider.of<ListsCubit>(context)
                                .emptyOrNotPage3InAlbumWithPrint &&        BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint.isEmpty?


        TextAlignForRequestAlbum(
        color: Colors.red,
        title:  tr(StringConstants.noNumOfPhotos)):   const SizedBox()
                       ,


                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),

                           TextAlignForRequestAlbum(title: tr(StringConstants.sidePhotos),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                           ///side
                            const SideOfFamilyPhotoForAlbumWithPrint(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint!.id==-1 &&

        BlocProvider.of<ListsCubit>(context)
            .emptyOrNotPage3InAlbumWithPrint
        ?   TextAlignForRequestAlbum(title: tr(StringConstants.NOSide),

                            color: Colors.red,) : const SizedBox(),


                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        );
      },
    );
  }
}

class WayOfWritingNamesForPrintAlbum extends StatelessWidget {
  const WayOfWritingNamesForPrintAlbum({Key? key}) : super(key: key);

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
                    value: BlocProvider.of<ListsCubit>(context)
                            .drillingTypeForAlbumWithPrint
                            ?.name ??
                        "",
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeDrillingTypeForAlbumWithPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                    },

                    items: List<DrillingType>.from(context
                                    .read<ListsCubit>()
                                    .lstDrillingTypeForAlbumWithPrint ??
                                []
                            // .map((e) => BaseIdNameModel(
                            //     e.id.toString(), e.name))
                            )
                        .map<DropdownMenuItem<String>>(
                      (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: MyColors.myBlack,
                                  fontSize: 14,
                                ),
                          ),
                        );
                      },
                    ).toList(),
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
class SideOfFamilyPhotoForAlbumWithPrint extends StatelessWidget {
  const SideOfFamilyPhotoForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return  Container(
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
                    value:
                    BlocProvider.of<ListsCubit>(context)
                        .sideImageForAlbumWithPrint
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeGetSideImageForAlbumWithPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                    },

                    items: List<SideImageSize>.from(context
                        .read<ListsCubit>()
                        .lstSideImageForAlbumWithPrint!
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                              color: MyColors.myBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    ).toList(),
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
class NextFormPage3FromAlbumWithPrint extends StatelessWidget {
  const NextFormPage3FromAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: ( ) {
          BlocProvider.of<AlbumDetailsRowCubit>(context).minusIndexOfSelectedRequestOfAlbum();
        } , icon: const Icon(Icons.arrow_back_ios)),
        Expanded(
          child: MaterialButton(
            textColor: MyColors.myWhite,
            color: MyColors.primaryColor,
            onPressed: ( )  {
              if(
                  BlocProvider.of<ListsCubit>(context).nameOfCouplesForAlbumPrint.isNotEmpty
                      &&

                      BlocProvider.of<ListsCubit>(context).drillingTypeForAlbumWithPrint?.id!=-1
                      &&
                      (
                          (
                              BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint!.id=="1"
                              &&  BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithPrint.isNotEmpty)
                          ||  BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint!.id=="0"
                      )
              &&(
                      (  BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint!.id=="1"
                          &&  BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint.isNotEmpty
                      &&  BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint!.id!=-1
                      )
                          ||  BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint!.id=="0"
                  )


              )

              {
                print(  BlocProvider.of<ListsCubit>(context).nameOfCouplesForAlbumPrint);
                print(   BlocProvider.of<ListsCubit>(context).drillingTypeForAlbumWithPrint);
                print(BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint!.id);
                print(BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint!.id);
                print("done Album 3");
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage3InAlbumWithPrint(b: false);

                BlocProvider.of<AlbumDetailsRowCubit>(context)
                    .plusIndexOfAlbumPrint();


              }else{
                print("no no no ");
                print(BlocProvider.of<ListsCubit>(context).withFamilyAlbumWithPrint!.id);
                print(BlocProvider.of<ListsCubit>(context).historyOfAlbumWithPrint!.id);
                BlocProvider.of<ListsCubit>(context)
                    .updateEmptyOrNotPage3InAlbumWithPrint(b: true);

                print("error");
              }
            }
            ,
            minWidth: MediaQuery.of(context).size.width,
            child: Text(tr(StringConstants.theNext)),
          ),
        ),
      ],
    );
  }
}
