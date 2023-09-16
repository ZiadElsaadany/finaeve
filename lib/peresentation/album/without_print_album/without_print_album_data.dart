import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/cart_screen/cart_screen.dart';
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
import '../../widgets/shared_widgets/text_input_template.dart';


class WithoutPrintAlbumData extends StatefulWidget {
  const WithoutPrintAlbumData({Key? key}) : super(key: key);

  @override
  State<WithoutPrintAlbumData> createState() => _WithoutPrintAlbumDataState();
}

class _WithoutPrintAlbumDataState extends State<WithoutPrintAlbumData> {
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
                    initialValue: BlocProvider.of<ListsCubit>(context).nameOfCouplesForWithoutAlbumPrint,
                    onChanged: (v) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCoupleNamesForWithoutAlbumPrint(v);

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
             BlocProvider.of<ListsCubit>(context).emptyOrNotPage3InAlbumWithoutPrint &&
             BlocProvider.of<ListsCubit>(context)
                      .nameOfCouplesForWithoutAlbumPrint
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
                  const WayOfWritingNamesForWithoutPrintAlbum(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  if (BlocProvider.of<ListsCubit>(context).emptyOrNotPage3InAlbumWithoutPrint && BlocProvider.of<ListsCubit>(context)
                      .drillingTypeForAlbumWithoutPrint!
                      .id ==
                      -1)
                    TextAlignForRequestAlbum

                      (
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
                                          .changeHistoryOfAlbumWithoutPrint("1");
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
                                        color: BlocProvider.of<ListsCubit>(context).historyOfAlbumWithoutPrint?.id=="1"
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
                                          .changeHistoryOfAlbumWithoutPrint("0");
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
                                          color:  BlocProvider.of<ListsCubit>(context).historyOfAlbumWithoutPrint?.id=="0"
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
                  BlocProvider.of<ListsCubit>(context).historyOfAlbumWithoutPrint?.id ==
                      "1"
                      ? Column(
                    children: [
                      TextAlignForRequestAlbum(
                          title: tr(StringConstants.dateOfCelebration)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextFormField(
                        initialValue: BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithoutPrint,

                        cursorColor: MyColors.primaryColor,
                        onChanged: (v) {
                          BlocProvider.of<ListsCubit>(context)
                              .changeHistoryDateForAlbumWithoutPrint(v);
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


                      BlocProvider.of<ListsCubit>(context).emptyOrNotPage3InAlbumWithoutPrint &&     BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithoutPrint.isEmpty?
                      TextAlignForRequestAlbum(
                          color: Colors.red,
                          title: tr(StringConstants.noHistoryDate))

                          :const SizedBox()
                    ],
                  )
                      : const SizedBox(),

                  TextInputTemplate(
                      initialValue: BlocProvider.of<ListsCubit>(context)
                          .descriptionForAlbumWithoutPrint,
                      onChanged: (c) {
                        BlocProvider.of<ListsCubit>(context)
                            .changeDescriptionForAlbumWithoutPrint(c.trim());


                      },
                      headerTxt: tr(StringConstants.theNotes),
                      hintText: tr(StringConstants.notes)),

                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        );
      },
    );
  }
}
class WayOfWritingNamesForWithoutPrintAlbum extends StatelessWidget {
  const WayOfWritingNamesForWithoutPrintAlbum({Key? key}) : super(key: key);

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
                        .drillingTypeForAlbumWithoutPrint
                        ?.name ??
                        "",
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeDrillingTypeForAlbumWithoutPrint(newValue!);
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

class NextFormPage3FromAlbumWithoutPrint extends StatelessWidget {
  const NextFormPage3FromAlbumWithoutPrint({Key? key}) : super(key: key);


  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {
        // TODO: implement listener

        if(state is SendRequestFailureWithoutAlbumStates) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }
        else   if(state is SendRequestSuccessWithoutAlbumStates) {
          debugPrint("success");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message)));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
            return CartScreen();
          }));
        }
      },
      builder: (context, state) {

        return   state is SendRequestLoadingWithoutAlbumStates ?
        const Center(
          child: CircularProgressIndicator(
            color: MyColors.primaryColor,
          ),
        )
            :Container(
          child: Row(
            children: [

              IconButton(
                onPressed: ( ) {
                  BlocProvider.of<AlbumDetailsRowCubit>(context).minusIndexOfRequestWithoutPrintAlbum();
                } ,
                icon : const Icon(
                    Icons.arrow_back_ios ) ,
              ),

              Expanded(
                child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: MyColors.primaryColor,
                  textColor: Colors.white,
                  onPressed: ( ) {
                    debugPrint (
                      "withExtensionOrNotForWithoutPrint.id= " +
                        BlocProvider
                            .of<ListsCubit>(context)
                            .withExtensionOrNotForWithoutPrint!.id
                    ) ;
                 if(
                 BlocProvider.of<ListsCubit>(context).nameOfCouplesForWithoutAlbumPrint.isNotEmpty
                     &&
                     BlocProvider.of<ListsCubit>(context).drillingTypeForAlbumWithoutPrint?.id!=-1
                     &&
                     (
                         BlocProvider.of<ListsCubit>(context).historyOfAlbumWithoutPrint!.id=="0" ||
                             BlocProvider.of<ListsCubit>(context).historyOfAlbumWithoutPrint!.id=="1"&&
                                 BlocProvider.of<ListsCubit>(context).historyDateForAlbumWithoutPrint.isNotEmpty
                     )&&
                     BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithoutPrint!=0
                 ) {
                   BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage3InAlbumWithoutPrint(b: false);
                   debugPrint(    "mini for with print :  "+ BlocProvider.of<ListsCubit>(context).miniForAlbumWithPrint             );
                       print(BlocProvider
                       .of<ListsCubit>(context)
                       .withExtensionOrNotForWithoutPrint!.id.toString());
                   BlocProvider.of<AlbumDetailsRowCubit>(context).sendAlbumRequestWithoutPrint(
                     cover_type_id:

                     BlocProvider
                         .of<ListsCubit>(context).albumMaterialTypeForAlbumWithoutPrint!.id==4?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .coverTypeForWithoutAlbumPrint
                         ?.id
                         .toString() ?? "":"",
                       context: context,
                       album_type: (BlocProvider
                           .of<AlbumDetailsRowCubit>(context)
                           .indexOfSelectedRequestOfAlbum +
                           1)
                           .toString(),
                       size_id:
                       BlocProvider
                           .of<ListsCubit>(context)
                           .currentSizeForWithoutPrintAlbum
                           ?.id
                           .toString() ?? "",
                       box: BlocProvider
                           .of<ListsCubit>(context)
                           .boxYesOrNoAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       with_extension: BlocProvider
                           .of<ListsCubit>(context)
                           .withExtensionOrNotForWithoutPrint
                           ?.id ?? ""
                           .toString(),

                       album_type_id:
                       BlocProvider
                           .of<ListsCubit>(context)
                           .albumMaterialTypeForAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       color_id: BlocProvider
                           .of<ListsCubit>(context)
                           .colorForAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       corner_id: BlocProvider
                           .of<ListsCubit>(context)
                           .cornerForAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       with_open_flash:
                       BlocProvider
                           .of<ListsCubit>(context)
                           .withUsbForAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       couple_name: BlocProvider
                           .of<ListsCubit>(context)
                           .nameOfCouplesForWithoutAlbumPrint ,
                       drilling_type_id:
                       BlocProvider
                           .of<ListsCubit>(context)
                           .drillingTypeForAlbumWithoutPrint
                           ?.id
                           .toString() ?? "",
                       with_date: BlocProvider
                           .of<ListsCubit>(context)
                           .historyOfAlbumWithoutPrint
                           ?.id ?? "",

                       //
                       description: BlocProvider
                           .of<ListsCubit>(context)
                           .descriptionForAlbumWithoutPrint,
                       // BlocProvider
                       //             .of<ListsCubit>(context)
                       //             .albumPrice
                       //             .toString()
                       album_price:BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithoutPrint.toString(),
                       //
                       model_image: BlocProvider
                           .of<ListsCubit>(context)
                           .modelImageForWithoutPrint
                           ?.id.toString() ?? "",
                       album_model:
                       BlocProvider.of<ListsCubit>(context).boxYesOrNoAlbumWithoutPrint!.id=="1"?
                       BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithoutPrint:null,

                     other_color: BlocProvider
                         .of<ListsCubit>(context)
                         .anotherColorTextForWithoutPrintAlbum ,
                     date:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithoutPrint
                         !.id=="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyDateForAlbumWithoutPrint:"",
                     extension_type_id:  BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithoutPrint!.id =="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .miniForAlbumWithoutPrint: ""  ,

                   );

                 }else {
                   BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage3InAlbumWithoutPrint(b: true);

                   debugPrint("not end of without");
                 }
                  },minWidth: MediaQuery.of(context).size.width,
                  child: Text(tr(StringConstants.addOrderToCart)),),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ( ) {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return CartScreen();
                  } ));
                } ,
                child : Container(
                  width: 82,
                  height: 50,

                  decoration: BoxDecoration(
                    color: MyColors.myYellow,
                    borderRadius: BorderRadius.circular(5) ,
                  ),
                  child: Icon(Icons.shopping_cart_rounded, color: MyColors.myWhite,),

                ) ,
              ),
            ],
          ),
        );
      },
    );
  }
}
