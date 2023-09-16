import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/peresentation/widgets/album_order_widgets/drop_down_button.dart';
import '/utilities/constants/string_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../models/list_models.dart';

import '../../widgets/album_order_widgets/text_align.dart';
import '../../widgets/circle_lottie_loading.dart';

class WithoutPrintSpecifications extends StatelessWidget {
  const WithoutPrintSpecifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is ListsLoading
            ? const CircleLoadingByLottie()
            : Container(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextAlignForRequestAlbum(
                        title: tr(StringConstants.theSizes)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const SizesDropDownWidgetForSizesScreenForWithout(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumWithoutPrint &&
                        BlocProvider.of<ListsCubit>(context).currentSizeForWithoutPrintAlbum?.id==-1?
                    TextAlignForRequestAlbum(
                        color: Colors.red,
                        title: tr(StringConstants.noSize)):const SizedBox(),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),


                    const BoxDropDownMenuForAlbumWithoutPrint(),
                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumWithoutPrint &&            BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint?.id==""?
                    TextAlignForRequestAlbum(
                        color: Colors.red,

                        title: tr(StringConstants.noBox)):const SizedBox(),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const ExtensionDropDownMenuForAlbumWithoutPrint(),

                    ///extension
                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumWithoutPrint &&            BlocProvider.of<ListsCubit>(context).withExtensionOrNotForWithoutPrint?.id==""?

                    TextAlignForRequestAlbum(
                        color: Colors.red,

                        title: tr(StringConstants.nowithExtension)):const SizedBox(),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),


                    BlocProvider.of<ListsCubit>(context)
                        .withExtensionOrNotForWithoutPrint
                        ?.id ==
                        "1"
                        ? Column(
                      children: [
                        WithExtensionSelectedItemsWithoutPrint(),
                        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumWithoutPrint &&           BlocProvider.of<ListsCubit>(context).miniForAlbumWithoutPrint.isEmpty?
                        TextAlignForRequestAlbum(
                            color: Colors.red,

                            title: tr(StringConstants.noExtension))   :  const SizedBox()
                      ],
                    )
                        : const SizedBox(),



                    /// images for box
                    if (BlocProvider.of<ListsCubit>(context)
                        .boxYesOrNoAlbumWithoutPrint
                        ?.id ==
                        "1")  const ImagesBoxForAlbumWithoutPrint() else const SizedBox(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                  ],
                ),
              );
      },
    );
  }
}





class NextFormPage1FromAlbumWithoutPrint extends StatelessWidget {
  const NextFormPage1FromAlbumWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: MyColors.myWhite,
      color: MyColors.primaryColor,
      onPressed: ( )  {
        if(BlocProvider.of<ListsCubit>(context).currentSizeForWithoutPrintAlbum!.id!=-1
            &&BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint!.id!=""&&
            (
                BlocProvider.of<ListsCubit>(context).withExtensionOrNotForWithoutPrint!.id=="0"
                    ||
                    (BlocProvider.of<ListsCubit>(context).withExtensionOrNotForWithoutPrint!.id=="1"&&
                    BlocProvider.of<ListsCubit>(context).miniForAlbumWithoutPrint.isNotEmpty)
            )&&
            (
            BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint!.id=="0"||
                BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint!.id=="1" &&
                    BlocProvider.of<ListsCubit>(context).modelImageForWithoutPrint!=null ||
                BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithoutPrint!=null
        )
        ){
          BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumWithoutPrint(b: false) ;

          print("done Album 1 ");
          BlocProvider.of<AlbumDetailsRowCubit>(context)
              .plusIndexOfCircleAvatarInAlbumWithoutPrint();

        }else{
          BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumWithoutPrint(b: true) ;
        }
      }
      ,
      minWidth: MediaQuery.of(context).size.width,
      child: Text(tr(StringConstants.theNext)),
    );
  }
}


//SizesDropDownWidgetForSizesScreen
class SizesDropDownWidgetForSizesScreenForWithout extends StatelessWidget {
  const SizesDropDownWidgetForSizesScreenForWithout({Key? key}) : super(key: key);

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
                        ? BlocProvider.of<ListsCubit>(context)
                        .currentSizeForWithoutPrintAlbum
                        ?.nameEng ??
                        ""
                        : BlocProvider.of<ListsCubit>(context)
                        .currentSizeForWithoutPrintAlbum
                        ?.name ??
                        "",
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCurrentSizeForAlbumWithoutPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                      debugPrint(
                          "id size Of AlbumWithPrint ${BlocProvider.of<ListsCubit>(context).currentSizeForWithoutPrintAlbum?.id ?? ""}");
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                              color: MyColors.myBlack,
                              fontSize: 16,
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


//BoxDropDownMenuForAlbumWithPrint
class BoxDropDownMenuForAlbumWithoutPrint extends StatelessWidget {
  const BoxDropDownMenuForAlbumWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DropDownButtonTemplate(
          items: context.read<ListsCubit>().listBoxOrNotForAlbumWithPrint ?? [],
          text: tr(StringConstants.theBox),
          value:
          context.read<ListsCubit>().boxYesOrNoAlbumWithoutPrint?.name ?? "",
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeBoxYesOrNoForWithoutPrint(value!);

            debugPrint(
                "id size Of AlbumWithPrint ${BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint?.id ?? ""}");
            if (BlocProvider.of<ListsCubit>(context)
                .boxYesOrNoAlbumWithoutPrint
                ?.id ==
                "0") {
              BlocProvider.of<ListsCubit>(context)
                  .makeChangeImageModelEqualNullForAlbumWithoutPrint();

            }
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);

          },
        );
      },
    );
  }
}

//extensions
class ExtensionDropDownMenuForAlbumWithoutPrint extends StatelessWidget {
  const ExtensionDropDownMenuForAlbumWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropDownButtonTemplate(
          text: tr(StringConstants.extension_type),
          items: BlocProvider.of<ListsCubit>(context)
              .listExtensionsOrNotForAlbumWithPrint ??
              [],
          value:
          context.read<ListsCubit>().withExtensionOrNotForWithoutPrint?.name ??
              "",
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeExtensionsYesOrNoForWithoutPrint(value!);
            debugPrint(
                "extension size Of AlbumWithPrint ${BlocProvider.of<ListsCubit>(context).withExtensionOrNotForWithoutPrint!.id.toString()}");
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);

          },
        );
      },
    );
  }
}

class WithExtensionSelectedItemsWithoutPrint extends StatefulWidget {
  const WithExtensionSelectedItemsWithoutPrint({Key? key}) : super(key: key);

  @override
  State<WithExtensionSelectedItemsWithoutPrint> createState() =>
      _WithExtensionSelectedItemsWithoutPrintState();
}

class _WithExtensionSelectedItemsWithoutPrintState
    extends State<WithExtensionSelectedItemsWithoutPrint> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {


       },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child:  ListView.separated(
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
                      BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[index] = !BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[index];
                      BlocProvider.of<ListsCubit>(context).updateMiniWithoutPrint(
                          BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                              &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==false&&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                              ?
                          "4": BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                              &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                              ? "4,3":
                          BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                              &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==true? "4,3,2":

                          BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==false
                              &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                              ?
                          "3": BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                              &&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                              &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==false&&
                              BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==true?"4,2":
                          BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2]==true?
                          "2" :
                          BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] == true && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2]==true?
                          "3,2" : ""
                      );

                      if( BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint?.id=="1"){
                        BlocProvider.of<ListsCubit>(context).getImagesFromExtensionLikeMiniFromApiWithoutPrint(
                            extension_type_id:
                            BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                                &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==false&&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                                ?
                            "4": BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                                &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                                ? "4,3":
                            BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                                &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==true? "4,3,2":

                            BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==false
                                &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==true&&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==false
                                ?
                            "3": BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                                &&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0]==true
                                &&BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] ==false&&
                                BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2] ==true?"4,2":
                            BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2]==true?
                            "2" :
                            BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[0] == false && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[1] == true && BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[2]==true?
                            "3,2" : ""




                        );
                        BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                      }
                      setState(() {});
                      print(BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: MyColors.myGray, width: 2),
                          color: BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum[index] == true
                              ? MyColors.primaryColor
                              : Colors.transparent),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Text(
                    /// localization here fot text   name_en
                    context.locale == const Locale("en")
                        ? BlocProvider.of<ListsCubit>(context)
                        .lstExtensionWithPrint![index]
                        .nameEng
                        : BlocProvider.of<ListsCubit>(context)
                        .lstExtensionWithPrint![index]
                        .name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: MyColors.myBlack,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
            itemCount: BlocProvider.of<ListsCubit>(context).lstBoolForWithoutAlbum.length,
          ),
        );
      },
    );
  }
}


class ImagesBoxForAlbumWithoutPrint extends StatefulWidget {
 const   ImagesBoxForAlbumWithoutPrint({Key? key}) : super(key: key);

  @override
  State<ImagesBoxForAlbumWithoutPrint> createState() => _ImagesBoxForAlbumWithoutPrintState();
}

class _ImagesBoxForAlbumWithoutPrintState extends State<ImagesBoxForAlbumWithoutPrint> {
  bool another  =false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {

        if(state  is GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }      },
      builder: (context, state) {
        return    state is  GetImagesFromExtensionLikeMiniFromApiLoadingWithoutPrintState?
        const Center(child: CircleLoadingByLottie())
            : Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            TextAlignForRequestAlbum(
                title: tr(StringConstants.chooseTheModel)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),

             GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),

              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return   GestureDetector(
                  onTap: (){
                    setState(() {
                      another= false;
                    });

                    BlocProvider.of<ListsCubit>(context).changeModelImagesForAlbumWithoutPrint(
                        BlocProvider.of<ListsCubit>(context).lstModelImageForWithPrint![index].id
                    );

                    BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                    debugPrint( BlocProvider.of<ListsCubit>(context).modelImageForWithoutPrint!.imageUrl );


                  },
                  child: Container (
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:

                        BlocProvider.of<ListsCubit>(context).modelImageForWithoutPrint?.id ==
                            BlocProvider.of<ListsCubit>(context).lstModelImageForWithPrint?.elementAt(index).id
                            ?MyColors.primaryColor:Colors.transparent
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
                            BlocProvider.of<ListsCubit>(context)
                                .lstModelImageForWithPrint?[index].imageUrl??"",
                            placeholder: (c,d)  {
                              return const SizedBox();
                            },
                            errorWidget: (c,x,d) {
                              return  const Icon(Icons.error);
                            },
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(tr(StringConstants.albumName),
                                textAlign: TextAlign.center,
                                style: TextStyle (
                                    fontSize: 14
                                ),
                              ),
                              Expanded(
                                child: Text(BlocProvider.of<ListsCubit>(context).lstModelImageForWithPrint?[index].name??"",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle (
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
              itemCount:BlocProvider.of<ListsCubit>(context)
                  .lstModelImageForWithPrint?.length??0,
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
                      setState(() {
                        another = !another;
                      });
                      BlocProvider.of<ListsCubit>(context)
                          .makeChangeImageModelEqualNullForAlbumWithoutPrint();
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: another ?
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
              MediaQuery.of(context).size.height * 0.02,
            ),
        another ?     Column(
              children: [
                Text(
                  tr(
                    StringConstants.uploadAnotherAlbum,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(
                    color: MyColors.myBlack,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  height:
                  MediaQuery.of(context).size.height * 0.02,
                ),
                BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithoutPrint !=
                    null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.3,
                        child: Stack(
                          alignment:
                          AlignmentDirectional
                              .topEnd,
                          children: [
                            Image.file(
                              BlocProvider.of<ListsCubit>(
                                  context)
                                  .uploadAnotherModelOfPHOTOForAlbumWithoutPrint
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
                                      .removeUploadAnotherModelOfPHOTOForAlbumWithoutPrint();
                                  BlocProvider.of<ListsCubit>(context).funGetPrice(context);

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
                    :  Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3
                  ),
                  decoration: BoxDecoration(
                      color: MyColors.myGray.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    onTap:() async{

                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );

                      if (result != null) {
                        BlocProvider.of<ListsCubit>(context)
                            .getImageFromGalleryForAlbumWithoutPrint(
                            File(
                                result.files.single.path!));
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
            ):SizedBox()
          ],
        );
      },
    );
  }
}




// SizedBox(
// height: MediaQuery.of(context).size.height * 0.04,
// ),
// // DropDownButtonTemplate(
// //   text: tr(StringConstants.theSizes),
// //   // value:context.read<ListsCubit>().currentSize.name ,
// //   items: List<BaseIdNameModel>.from(context
// //       .read<ListsCubit>()
// //       .dataAllMenues
// //       !.albumSizes
// //       !.map((e) => BaseIdNameModel(e.id.toString(), e.name))),
// //   onChanged: (newValue){
// //     // context.read<ListsCubit>().currentSize = context.read<ListsCubit>().dataAllMenues.albumSizes.where((element) => element.name==);
// //   },
// // ),
// Align(
// alignment: Alignment.bottomRight,
// child: Text(
// tr(StringConstants.theSizes),
// style:
// Theme.of(context).textTheme.headlineLarge!.copyWith(
// color: MyColors.myBlack,
// fontSize: 12,
// ),
// textAlign: TextAlign.start,
// ),
// ),
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.01,
// ),
// Container(
// decoration: BoxDecoration(
// border: Border.all(color: MyColors.myGray),
// borderRadius: const BorderRadius.all(
// Radius.circular(8),
// )),
// padding: const EdgeInsets.all(9.0),
// child: Row(
// children: [
// Image.asset(ImageConstants.albumRequest),
// // Your desired icon
// const SizedBox(width: 8.0),
// // Space between icon and label
// Expanded(
// child: DropdownButtonHideUnderline(
// child: DropdownButton<String>(
// isExpanded: true,
// // To take all possible horizontal space
// value: BlocProvider.of<ListsCubit>(context)
// .currentSize
//     ?.name ??
// "",
// onChanged: (newValue) {
// BlocProvider.of<ListsCubit>(context)
//     .changeCurrentSizeForAlbumWithPrint(newValue!);
// BlocProvider.of<ListsCubit>(context)
//     .funGetPrice(context);
// },
//
// items: List<AlbumSize>.from(context
//     .read<ListsCubit>()
// .dataAllMenues!
// .albumSizes!
// // .map((e) => BaseIdNameModel(
// //     e.id.toString(), e.name))
// )
// .map<DropdownMenuItem<String>>(
// (item) {
// return DropdownMenuItem<String>(
// value: item.name,
// child: Text(
// item.name,
// style: Theme.of(context)
//     .textTheme
//     .headlineLarge!
//     .copyWith(
// color: MyColors.myBlack,
// fontSize: 10,
// ),
// ),
// );
// },
// ).toList() ??
// [],
// isDense: true,
// ),
// ),
// ),
// ],
// ),
// ),
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.03,
// ),
// DropDownButtonTemplate(
// items: context
//     .read<ListsCubit>()
// .dataAllMenues!
// .yesOrNoOptions,
// text: tr(StringConstants.theBox),
// value: context.read<ListsCubit>().boxYesOrNo?.name,
// onChanged: (value) {
// BlocProvider.of<ListsCubit>(context)
//     .changeBoxYesOrNoForWithPrint(value!);
// if (BlocProvider.of<ListsCubit>(context)
//     .boxYesOrNo
//     ?.id ==
// "0") {
// BlocProvider.of<ListsCubit>(context)
//     .makeChangeImageModelEqualNull();
// }
// BlocProvider.of<ListsCubit>(context)
//     .funGetPrice(context);
// },
// ),
// BlocProvider.of<ListsCubit>(context).boxYesOrNo?.id == "0"
// ? const SizedBox()
// : Column(
// children: [
// Align(
// alignment: Alignment.bottomRight,
// child: Text(
// tr(StringConstants.chooseTheModel),
// style: Theme.of(context)
// .textTheme
//     .headlineLarge!
// .copyWith(
// color: MyColors.myBlack,
// fontSize: 12,
// ),
// textAlign: TextAlign.start,
// )),
// SizedBox(
// height:
// MediaQuery.of(context).size.height * 0.02,
// ),
// AlbumOrderGridView(
// images: BlocProvider.of<ListsCubit>(context)
// .dataAllMenues!
// .modelImages!,
// ),
// const SizedBox(
// height: 15,
// ),
// Align(
// alignment: AlignmentDirectional.topStart,
// child: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// GestureDetector(
// onTap: () {
// BlocProvider.of<ListsCubit>(context)
//     .makeChangeImageModelEqualNull();
// },
// child: Stack(
// alignment: AlignmentDirectional.center,
// children: [
// Image.asset(
// "assets/images/Rectangle 695.png",
// ),
// Image.asset(
// "",
// ),
// ],
// ),
// ),
// const SizedBox(
// width: 10,
// ),
// Text(
// tr(StringConstants.other),
// style: Theme.of(context)
// .textTheme
//     .headlineLarge!
// .copyWith(
// color: MyColors.myBlack,
// fontSize: 12,
// ),
// )
// ],
// ),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height * 0.02,
// ),
// BlocProvider.of<ListsCubit>(context).modelImage ==
// null
// ? Column(
// children: [
// Text(
// tr(
// StringConstants.uploadAnotherAlbum,
// ),
// style: Theme.of(context)
// .textTheme
//     .headlineLarge!
// .copyWith(
// color: MyColors.myBlack,
// fontSize: 10,
// ),
// ),
// const SizedBox(
// height: 15,
// ),
// BlocProvider.of<ListsCubit>(context)
// .uploadAnotherModelOfPHOTO !=
// null
// ? SizedBox(
// height: MediaQuery.of(context)
// .size
//     .height *
// 0.3,
// width: MediaQuery.of(context)
// .size
//     .width,
// child: Row(
// mainAxisSize:
// MainAxisSize.min,
// children: [
// Expanded(
// child: Stack(
// alignment:
// AlignmentDirectional
//     .topEnd,
// children: [
// Image.file(
// BlocProvider.of<ListsCubit>(
// context)
// .uploadAnotherModelOfPHOTO
// as File,
//     fit: BoxFit.cover,
// ),
// Padding(
// padding:
// const EdgeInsets
//     .all(8.0),
// child:
// GestureDetector(
// onTap: () {
// BlocProvider.of<
// ListsCubit>(
// context)
//     .removeUploadAnotherModelOfPHOTO();
// },
// child:
// const CircleAvatar(
// backgroundColor:
// Colors
//     .red,
// child:
// Icon(
// Icons
//     .close,
// color: Colors
//     .white,
// )),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// )
// : const ListTileUploadTemplate(),
// ],
// )
// : SizedBox(),
// ],
// ),
//
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.01,
// ),
// DropDownButtonTemplate(
// text: tr(StringConstants.extension_type),
// items: BlocProvider.of<ListsCubit>(context)
// .dataAllMenues!
// .yesOrNoOptions,
// value:
// context.read<ListsCubit>().withExtensionOrNot?.name ??
// "",
// onChanged: (value) {
// BlocProvider.of<ListsCubit>(context)
//     .changeWithExtensionWithNot(value!);
// BlocProvider.of<ListsCubit>(context)
//     .funGetPrice(context);
// },
// ),
// BlocProvider.of<ListsCubit>(context)
// .withExtensionOrNot
//     ?.id ==
// "1"
// ? SizedBox(
// height: MediaQuery.of(context).size.height * 0.05,
// child: ListView.separated(
// separatorBuilder: (ctx, index) {
// return const SizedBox(
// width: 10,
// );
// },
// scrollDirection: Axis.horizontal,
// itemBuilder: (ctx, index) {
// return Row(
// children: [
// GestureDetector(
// onTap: () {
// BlocProvider.of<ListsCubit>(context)
//     .changeExtensions(
// BlocProvider.of<ListsCubit>(
// context)
//     .dataAllMenues!
//     .extensions![index]
//     .name);
// BlocProvider.of<ListsCubit>(context)
//     .funGetPrice(context);
// },
// child: Container(
// width:
// MediaQuery.of(context).size.width *
// 0.1,
// height:
// MediaQuery.of(context).size.height *
// 0.03,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// border: Border.all(
// color: MyColors.myGray,
// width: 2),
// color: BlocProvider.of<ListsCubit>(
// context)
//     .extension
//     ?.id ==
// BlocProvider.of<ListsCubit>(
// context)
//     .dataAllMenues!
//     .extensions![index]
//     .id
// ? MyColors.primaryColor
//     : Colors.transparent),
// ),
// ),
// SizedBox(
// width:
// MediaQuery.of(context).size.width *
// 0.01),
// Text(
// /// localization here fot text   name_en
// BlocProvider.of<ListsCubit>(context)
//     .dataAllMenues!
//     .extensions![index]
//     .name,
// style: const TextStyle(
// fontSize: 12,
// color: MyColors.myBlack),
// ),
// ],
// );
// },
// itemCount: BlocProvider.of<ListsCubit>(context)
// .dataAllMenues!
// .extensions!
// .length,
// ),
// )
// : const SizedBox(),
//
// const SizedBox(
// height: 15,
// ),
// // DropdownButtonHideUnderline(
// //   child: DropdownButton<String>(
// //     isExpanded: true,
// //     // To take all possible horizontal space
// //     value: BlocProvider.of<ListsCubit>(context).pages.name,
// //     onChanged: (newValue) {
// //       BlocProvider.of<ListsCubit>(context).changePages(newValue!);
// //     },
// //     items: List<BaseIdNameModel>.from(context
// //         .read<ListsCubit>()
// //         .dataAllMenues!
// //         .pages!
// //       // .map((e) => BaseIdNameModel(
// //       //     e.id.toString(), e.name))
// //     )
// //         .map<DropdownMenuItem<String>>(
// //           (item) {
// //         return DropdownMenuItem<String>(
// //           value: item.name,
// //           child: Text(item.name),
// //         );
// //       },
// //     ).toList() ??
// //         [],
// //     isDense: true,
// //   ),
// // ),
// // DropDownButtonTemplate(
// //   items: context.read<ListsCubit>().dataAllMenues!.pages,
// //   text: tr(StringConstants.pagesNum),
// //   value: context.read<ListsCubit>().pages.name,
// //   onChanged: (value) {
// //     BlocProvider.of<ListsCubit>(context).changePages(value!) ;
// //     BlocProvider.of<ListsCubit>(context).funGetPrice(context);
// //
// //
// //   },
// // ),
//
// // DropDownButtonTemplate(
// //   text: tr(StringConstants.withOrWithoutEdit),
// //   items: context.read<ListsCubit>().dataAllMenues!.yesOrNoOptions,
// //   value: context.read<ListsCubit>().withEditOrNot.name,
// //   onChanged: (value) {
// //     BlocProvider.of<ListsCubit>(context).changeEditOrNot(value!);
// //     BlocProvider.of<ListsCubit>(context).funGetPrice(context);
// //   },
// // ),
// // SizedBox(
// //   height: MediaQuery.of(context).size.height * 0.02,
// // ),