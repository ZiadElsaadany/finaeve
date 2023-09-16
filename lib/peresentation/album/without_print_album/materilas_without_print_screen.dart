import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../models/list_models.dart';
import '../../widgets/album_order_widgets/text_align.dart';

class WithoutPrintMaterials extends StatelessWidget {
   WithoutPrintMaterials({Key? key}) : super(key: key);


  bool  checkedUsb = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: BlocConsumer<ListsCubit, ListsState>(
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
                    TextAlignForRequestAlbum(title:  tr(StringConstants.materialType)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const MaterialTypesScreenWithoutPrint(),

                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithoutPrint &&        BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint?.id==-1?

                    TextAlignForRequestAlbum(title:  tr(StringConstants.noMaterial),
                      color: Colors.red,
                    ): SizedBox(),


                    BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint!.id==4?     Column(
                      children: [

                        TextAlignForRequestAlbum(title: tr(StringConstants.cover_type)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const   CoverTypesScreenWithoutPrint(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithoutPrint &&        BlocProvider.of<ListsCubit>(context).coverTypeForWithoutAlbumPrint!.id==-1?
                        TextAlignForRequestAlbum(title:  tr(StringConstants.noCoverType),
                          color: Colors.red,

                        ):
                        const SizedBox(),
                      ],
                    ) : const SizedBox(),



                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    // colors

                    TextAlignForRequestAlbum(title:  tr(StringConstants.color)),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ///color
                    const ColorScreenWithoutPrint() ,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    BlocProvider.of<ListsCubit>(context).colorForAlbumWithoutPrint?.id == 10
                        ? Column(
                      children: [
                        TextAlignForRequestAlbum(title:     tr(StringConstants.anotherColor)),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextFormField(
                          cursorColor: MyColors.primaryColor,
                          onChanged: (c) {
                            BlocProvider.of<ListsCubit>(context)
                                .setAnotherColorTextForWithoutPrintAlbum(c.trim());

                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: MyColors.myGray)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: MyColors.myGray)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: MyColors.myGray)),
                          ),
                        ),
                        BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithoutPrint &&     BlocProvider.of<ListsCubit>(context).anotherColorTextForWithoutPrintAlbum.isEmpty?
                        TextAlignForRequestAlbum(title: tr(StringConstants.noAnotherColor),
                          color: Colors.red,
                        ): SizedBox(),

                      ],
                    )
                        : const SizedBox(),








                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    TextAlignForRequestAlbum(title:  tr(StringConstants.theAngles) ) ,

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    // corner
                    const CornerScreenWithoutPrint(),

                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithoutPrint &&        BlocProvider.of<ListsCubit>(context).cornerForAlbumWithoutPrint!.id == -1?
                    TextAlignForRequestAlbum(title:tr(StringConstants.noCorner) ,
                      color: Colors.red,

                    ): SizedBox() ,

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(StringConstants.withUSB),
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: MyColors.grayText,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    BlocProvider.of<ListsCubit>(context).changeWithUsbForAlbumWithoutPrint(
                                        "1"
                                    );
                                    BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MyColors.myGray, width: 2),
                                      color:

                                      BlocProvider.of<ListsCubit>(context).withUsbForAlbumWithoutPrint?.id=="1"? MyColors.primaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                Text(
                                  tr(StringConstants.yes),
                                  style:
                                  Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    color: MyColors.grayText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: ( ) {
                                    BlocProvider.of<ListsCubit>(context).changeWithUsbForAlbumWithoutPrint(
                                        "0"
                                    );
                                    BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                                  } ,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                        Border.all(color: MyColors.myGray, width: 2),
                                        color:  BlocProvider.of<ListsCubit>(context).withUsbForAlbumWithoutPrint?.id=="0"
                                            ? MyColors.primaryColor:Colors.transparent
                                    ),
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                Text(
                                  tr(StringConstants.no),
                                  style:
                                  Theme.of(context).textTheme.headlineLarge!.copyWith(
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



                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}


class NextFormPage2FromAlbumWithoutPrint extends StatelessWidget {
  const NextFormPage2FromAlbumWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: (){
          BlocProvider.of<AlbumDetailsRowCubit>(context).minusIndexOfRequestWithoutPrintAlbum();

        } , icon: Icon(Icons.arrow_back_ios))
        ,
        Expanded(
          child: MaterialButton(
            textColor: MyColors.myWhite,
            color: MyColors.primaryColor,
            onPressed: ( )  {
              print( BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint?.id.toString());
              print( BlocProvider.of<ListsCubit>(context).colorForAlbumWithoutPrint?.id.toString());
              if(

                  BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint?.id!=-1
                       &&
                  BlocProvider.of<ListsCubit>(context).cornerForAlbumWithoutPrint?.id!=-1
              &&(
                      BlocProvider.of<ListsCubit>(context).colorForAlbumWithoutPrint?.id!=10 ||
                          BlocProvider.of<ListsCubit>(context).colorForAlbumWithoutPrint?.id==10&&
                              BlocProvider.of<ListsCubit>(context).anotherColorTextForWithoutPrintAlbum.isNotEmpty
                  )

              ){
                if(  BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint?.id== 4 &&

                    BlocProvider.of<ListsCubit>(context).coverTypeForWithoutAlbumPrint?.id!=-1
                ) {
                  print("page 2 in material without print ");
                  BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage2InAlbumWithoutPrint(b: false);
                      BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .plusIndexOfCircleAvatarInAlbumWithoutPrint();

                }else if(BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint?.id!= 4 ){
                  print("page 2 in material without print ");
                  BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage2InAlbumWithoutPrint(b: false);
                  BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .plusIndexOfCircleAvatarInAlbumWithoutPrint();

                }

              }else{
                BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage2InAlbumWithoutPrint(b: true);

                print("errror");
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

class MaterialTypesScreenWithoutPrint extends StatelessWidget {
  const MaterialTypesScreenWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
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
                        .albumMaterialTypeForAlbumWithoutPrint
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeAlbumMaterialTypeForAlbumWithoutPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                    },

                    items: List<Album>.from(context
                        .read<ListsCubit>()
                        .listOfAlbumMaterialTypeForAlbumWithPrint??[]
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                color: MyColors.myBlack ,
                                fontSize: 14
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
class CoverTypesScreenWithoutPrint extends StatelessWidget {
  const CoverTypesScreenWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
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
                        .coverTypeForWithoutAlbumPrint
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCoverTypeForAlbumWithoutPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                    },

                    items: List<CoverType>.from(context
                        .read<ListsCubit>()
                        .lstOfCoverType??[]
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                color: MyColors.myBlack ,
                                fontSize: 14
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
class ColorScreenWithoutPrint extends StatelessWidget {
  const ColorScreenWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
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
                        .colorForAlbumWithoutPrint
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeColorTypeForAlbumWithoutPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                    },

                    items: List<ColorResp>.from(context
                        .read<ListsCubit>()
                        .lstColorForAlbumWithPrint??[]
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                color: MyColors.myBlack ,
                                fontSize: 14
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
class CornerScreenWithoutPrint extends StatelessWidget {
  const CornerScreenWithoutPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
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
                        .cornerForAlbumWithoutPrint
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCornerForAlbumWithoutPrint(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                    },

                    items: List<Corner>.from(context
                        .read<ListsCubit>()
                        .lstCornerForAlbumWithPrint??[]
                      // .map((e) => BaseIdNameModel(
                      //     e.id.toString(), e.name))
                    )
                        .map<DropdownMenuItem<String>>(
                          (item) {
                        return DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                color: MyColors.myBlack ,
                                fontSize: 14
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