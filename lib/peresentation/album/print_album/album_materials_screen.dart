import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../models/list_models.dart';
import '../../widgets/album_order_widgets/text_align.dart';

class AlbumMaterialScreen extends StatefulWidget {
  const AlbumMaterialScreen({Key? key}) : super(key: key);
  static const String id = 'album material';

  @override
  State<AlbumMaterialScreen> createState() => _AlbumMaterialScreenState();
}

class _AlbumMaterialScreenState extends State<AlbumMaterialScreen> {

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
                    const MaterialTypesScreen(),

                   BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithPrint && BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint?.id==-1?

                    TextAlignForRequestAlbum(title:  tr(StringConstants.noMaterial),
                    color: Colors.red,
                    ): SizedBox(),


        BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint!.id==4?     Column(
                    children: [

                      TextAlignForRequestAlbum(title: tr(StringConstants.cover_type)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const   CoverTypesScreen(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithPrint &&    BlocProvider.of<ListsCubit>(context).coverTypeForAlbumPrint!.id==-1?
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
                   const ColorScreen() ,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    BlocProvider.of<ListsCubit>(context).colorForAlbumWithPrint?.id == 10
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
                                      .setAnotherColorTextForPrintAlbum(c.trim());

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
                              BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithPrint &&     BlocProvider.of<ListsCubit>(context).anotherColorTextForPrintAlbum.isEmpty?
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
                   const CornerScreen(),

                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage2InAlbumWithPrint && BlocProvider.of<ListsCubit>(context).cornerForAlbumWithPrint!.id == -1?
                    TextAlignForRequestAlbum(title:tr(StringConstants.noCorner) ,
                      color: Colors.red,

                    ) :    SizedBox(),

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
                                      BlocProvider.of<ListsCubit>(context).changeWithUsbForAlbumWithPrint(
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

                                      BlocProvider.of<ListsCubit>(context).withUsbForAlbumWithPrint?.id=="1"? MyColors.primaryColor
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
                                      BlocProvider.of<ListsCubit>(context).changeWithUsbForAlbumWithPrint(
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
                                        color:  BlocProvider.of<ListsCubit>(context).withUsbForAlbumWithPrint?.id=="0"
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


class NextFormPage2FromAlbumWithPrint extends StatelessWidget {
  const NextFormPage2FromAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: (){
          BlocProvider.of<AlbumDetailsRowCubit>(context).minusIndexOfSelectedRequestOfAlbum();

        } , icon: Icon(Icons.arrow_back_ios))
        ,
        Expanded(
          child: MaterialButton(
            textColor: MyColors.myWhite,
            color: MyColors.primaryColor,
            onPressed: ( )  {
              if(

              (
                  BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint?.id!=-1
                      &&
                      BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint?.id!=4
                      ||
                      BlocProvider.of<ListsCubit>(context).albumMaterialTypeForAlbumWithPrint?.id==4&&
                          BlocProvider.of<ListsCubit>(context).coverTypeForAlbumPrint?.id!=-1
              ) &&
                  BlocProvider.of<ListsCubit>(context).cornerForAlbumWithPrint?.id!=-1&&(
                  BlocProvider.of<ListsCubit>(context).colorForAlbumWithPrint?.id!=-1
                      ||   BlocProvider.of<ListsCubit>(context).colorForAlbumWithPrint?.id==1 &&
                      BlocProvider.of<ListsCubit>(context).anotherColorTextForPrintAlbum.isNotEmpty
              )
                  &&BlocProvider.of<ListsCubit>(context).withUsbForAlbumWithPrint?.id!=""

              ){
                BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage2InAlbumWithPrint(b: false);

                BlocProvider.of<AlbumDetailsRowCubit>(context)
                    .plusIndexOfAlbumPrint();


              }else{
                BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage2InAlbumWithPrint(b: true);

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

class MaterialTypesScreen extends StatelessWidget {
  const MaterialTypesScreen({Key? key}) : super(key: key);

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
                    .albumMaterialTypeForAlbumWithPrint
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeAlbumMaterialTypeForAlbumWithPrint(newValue!);
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
class CoverTypesScreen extends StatelessWidget {
  const CoverTypesScreen({Key? key}) : super(key: key);

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
                    .coverTypeForAlbumPrint
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeCoverTypeForAlbumWithPrint(newValue!);
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
class ColorScreen extends StatelessWidget {
  const ColorScreen({Key? key}) : super(key: key);

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
                    .colorForAlbumWithPrint
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeColorTypeForAlbumWithPrint(newValue!);
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
class CornerScreen extends StatelessWidget {
  const CornerScreen({Key? key}) : super(key: key);

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
                    .cornerForAlbumWithPrint
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeCornerForAlbumWithPrint(newValue!);
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
