import 'package:easy_localization/easy_localization.dart';
import '/utilities/constants/photos.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../models/list_models.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../widgets/album_order_widgets/text_align.dart';

class AccessoriesOrderScreen extends StatefulWidget {
  const AccessoriesOrderScreen({Key? key}) : super(key: key);

  @override
  State<AccessoriesOrderScreen> createState() => _AccessoriesOrderScreenState();
}

class _AccessoriesOrderScreenState extends State<AccessoriesOrderScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        if (state is SendAccessoriesOrderLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(state.message),
          ));
        } else if (state is SendAccessoriesOrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextAlignForRequestAlbum(
              title:
                tr(StringConstants.accessories_type)
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.myGray),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  )),
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: [
                  SvgPicture.asset(PhotosConstants.albumIconG, ),
                  // Your desired icon
                  const SizedBox(width: 8.0),
                  // Space between icon and label
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        // To take all possible horizontal space
                        value: BlocProvider.of<ListsCubit>(context)
                            .accessoriesTypeForFiller
                            ?.name,
                        onChanged: (newValue) {
                          BlocProvider.of<ListsCubit>(context)
                              .changeAccessoriesType(newValue!);

                            BlocProvider.of<ListsCubit>(context)
                                .getPriceToAccessories(context);


                        },

                        items: List<BaseIdNameModel>.from(context
                                    .read<ListsCubit>()
                                    .lstOfAccessoriesTypeForFiller!
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
            ),


            BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories &&    BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id ==""?
            TextAlignForRequestAlbum(
              color:Colors.red,
                title:
                tr(StringConstants.noAccessoriesType)
            ) :SizedBox( ) ,




            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id == "1"
                ? Column(
                    children: [
                      TextAlignForRequestAlbum(title:  tr(StringConstants.accessories_type_board)
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
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
                                      .boardSizeAcceso
                                      ?.name,
                                  onChanged: (newValue) {
                                    BlocProvider.of<ListsCubit>(context)
                                        .changeboardSizeAcceso(newValue!);
                                    BlocProvider.of<ListsCubit>(context).getPriceToAccessories(context);
                                  },

                                  items: List<BoardSize>.from(context
                                              .read<ListsCubit>()
                                              .lstBoardSize!
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
                      ),

        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories &&
         BlocProvider.of<ListsCubit>(context).boardSizeAcceso?.id== -1 ?
                      TextAlignForRequestAlbum(title:  tr(StringConstants.noBoardSize),
                      color: Colors.red,
                      )
                              :
                          SizedBox(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),



                    ],
                  )
                : BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id ==
                        "2"
                    ? Column(
                        children: [
                          TextAlignForRequestAlbum(title:  tr(StringConstants.sizeOfAccessoriesPaint)),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
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
                                              .printSize
                                              ?.name,
                                      onChanged: (newValue) {
                                        BlocProvider.of<ListsCubit>(context)
                                            .changePrintSize(newValue!);
                                        BlocProvider.of<ListsCubit>(context)
                                            .getPriceToAccessories(context);
                                      },

                                      items: List<PrintSize>.from(context
                                                  .read<ListsCubit>()
                                                  .lstPrintSize!
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
                          ),

        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories                               && BlocProvider.of<ListsCubit>(context).printSize?.id== -1 ?
                          TextAlignForRequestAlbum(
                              color: Colors.red,
                              title:  tr(StringConstants.noPrintSize) )
                              :
                          SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                        ],
                      )
                    : BlocProvider.of<ListsCubit>(context)
                                .accessoriesTypeForFiller
                                ?.id ==
                            "4"
                        ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),

                              TextAlignForRequestAlbum(
                                  title: tr(StringConstants.theNewlywedsName)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                initialValue: BlocProvider.of<ListsCubit>(context).nameOfCouplesForAccessories,
                                onChanged: (v) {
                                  BlocProvider.of<ListsCubit>(context)
                                      .changeCoupleNameForAccessories(v);

                                },
                                cursorColor: MyColors.primaryColor,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(PhotosConstants.albumIconG, ),
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
        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories                                   &&  BlocProvider.of<ListsCubit>(context)
                                  .nameOfCouplesForAccessories
                                  .isEmpty
                                  ? TextAlignForRequestAlbum(
                                  color: Colors.red,
                                  title: tr(StringConstants.noCouplesName))
                                  : const SizedBox(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),



                              ///WAY TO WRITING THE NAMES

                          TextAlignForRequestAlbum(title:  tr(StringConstants.wayOfWritingTheNames) ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
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
                                          value: BlocProvider.of<ListsCubit>(
                                                  context)
                                              .drillingType
                                              ?.name,
                                          onChanged: (newValue) {
                                            BlocProvider.of<ListsCubit>(context)
                                                .changeDrillingForAccessories(newValue!);
                                            BlocProvider.of<ListsCubit>(context)
                                                .getPriceToAccessories(context);
                                          },

                                          items: List<DrillingType>.from(context
                                                      .read<ListsCubit>()
                                                      .lstDrillingTypeForAlbumWithPrint!
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
                              ),

        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories                                   &&    BlocProvider.of<ListsCubit>(context).drillingType?.id ==-1?

                              TextAlignForRequestAlbum(title:  tr(StringConstants.noWritingName) ,
                              color: Colors.red,
                              )
                                  : SizedBox(),



SizedBox(
  height: MediaQuery.of(context).size.height*0.03,
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
                                      TextAlignForRequestAlbum(title: tr(StringConstants.dateOfTheOccasion)),

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
                                                      .changeHistoryOfAccessories("1");


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
                                                    color: BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id=="1"
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
                                                      .changeHistoryOfAccessories("0");



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
                                                      color:  BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id=="0"
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
                              BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id ==
                                  "1"
                                  ? Column(
                                children: [
                                  TextAlignForRequestAlbum(
                                      title: tr(StringConstants.dateOfCelebration)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  TextFormField(
                                    initialValue: BlocProvider.of<ListsCubit>(context).historyDateForAccessories,

                                    cursorColor: MyColors.primaryColor,
                                    onChanged: (v) {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeHistoryDateForDateForAccessories(v);
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


                                  BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories
        &&   BlocProvider.of<ListsCubit>(context).historyDateForAccessories.isEmpty?
                                  TextAlignForRequestAlbum(
                                      color: Colors.red,
                                      title: tr(StringConstants.noHistoryDate))

                                      :const SizedBox()
                                ],
                              )
                                  : const SizedBox(),

                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.03,
                              ),

                              TextAlignForRequestAlbum(title:  tr(StringConstants.color)),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              ColorScreenAccessories(),
                              BlocProvider.of<ListsCubit>(context).colorForAccessories?.id == 10
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
                                          .setAnotherColorTextForAccessories(c.trim());

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
        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumAccessories
        && BlocProvider.of<ListsCubit>(context).anotherColorTextForAccessories.isEmpty?
                                  TextAlignForRequestAlbum(title: tr(StringConstants.noAnotherColor),
                                    color: Colors.red,
                                  ): SizedBox(),

                                ],
                              )
                                  : const SizedBox(),


                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.03,
                              )

                            ],
                          )
                        : const SizedBox(),
        Column(
        children: [
        Align(
        alignment: Alignment.bottomRight,
        child: Text(
        tr(StringConstants.theNotes),
        style:  Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: MyColors.myBlack,
        fontSize: 14,
        ),
        textAlign: TextAlign.start,
        ),
        ),
        SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
        ),
        TextFormField(
        initialValue:   BlocProvider.of<ListsCubit>(context).descriptionForAccessories,
        onChanged: (c){
        BlocProvider.of<ListsCubit>(context)
            .changeDescriptionForAccessories(c.trim());
        setState(() {

        });
        print(
            BlocProvider.of<ListsCubit>(context).descriptionForAccessories
        ) ;
        },
        decoration: InputDecoration(
        hintText: tr(StringConstants.notes),
        hintStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: MyColors.grayText,
        fontSize: 14,
        ),
        enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: MyColors.deepGray)),
        focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: MyColors.deepGray),
        ),
        ),
        maxLines: 3,
        cursorColor: MyColors.deepGray,
        ),
        ],
        )

          ],
        );
      },
    );
  }
}
class ColorScreenAccessories extends StatelessWidget {
  const ColorScreenAccessories({Key? key}) : super(key: key);

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
                        .colorForAccessories
                        ?.name,
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeColorTypeForAccessories(newValue!);



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

class SendRequestAccessories extends StatelessWidget {
  const SendRequestAccessories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {
        // TODO: implement listener


        if(state is SendRequestForSuccessAccessoriesStates) {
          debugPrint("success");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message)));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
            return CartScreen();
          }));
        }
     else   if(state is SendRequestForSuccessMagazineStates) {
          debugPrint("success");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message)));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
            return CartScreen();
          }));
        }
       else if(state is SendRequestForFailureAccessoriesStates) {
          debugPrint("failure");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        } else if(state is SendRequestForFailureMagazineStates) {
          debugPrint("failure");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }

      },
      builder: (context, state) {

        return   state is SendRequestForPrintWithLoadingAccessories

            ||state is SendRequestForPrintWithLoadingMagazine?
            ?
        const Center(
          child: CircularProgressIndicator(
            color: MyColors.primaryColor,
          ),
        )
            :Container(
          child: Row(
            children: [


              Expanded(
                child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: MyColors.primaryColor,
                  textColor: Colors.white,
            onPressed: () {
                    debugPrint( "Send Accessories");

          if(
          BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id=="3"&&
          BlocProvider.of<ListsCubit>(context).resultAcssPrice!=0
          )  {
            BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumAccessories(b: false) ;
            print("success 3 ");

            BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForAccessories(
              color_id: "",
                other_color: "",
                context: context,
                album_type: "4",
                accessories_type: "3",
                description: BlocProvider.of<ListsCubit>(context)
                    .descriptionForAccessories,
                album_price: BlocProvider.of<ListsCubit>(context)
                    .resultAcssPrice
                    .toString(),
                accessories_type_board:
                "",
                accessories_type_print:
               "",
                couple_name:"" ,
                drilling_type_id:"",
                with_date:"",
                date:""
            ) ;
          }
          else if(

          BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id=="1"
          &&  BlocProvider.of<ListsCubit>(context).boardSizeAcceso?.id!=-1 &&
              BlocProvider.of<ListsCubit>(context).boardPrice!=0
          ) {
            BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumAccessories(b: false) ;
            print("success 3 ");

            BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForAccessories(
              color_id: "",
                other_color: "",
                context: context,
                album_type: "4",
                accessories_type: "1",
                description: BlocProvider.of<ListsCubit>(context)
                    .descriptionForAccessories,
                album_price: BlocProvider.of<ListsCubit>(context)
                    .boardPrice
                    .toString(),
                accessories_type_board:
                BlocProvider.of<ListsCubit>(context)
                    .boardSizeAcceso
                    ?.id
                    .toString() ??
                    "",
                accessories_type_print:"",
                couple_name:"",
                drilling_type_id:"",
                with_date:"",
                date:""
            ) ;
          }else if(
          BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id=="2"
&&
              BlocProvider.of<ListsCubit>(context).printSize?.id!=-1 &&
              BlocProvider.of<ListsCubit>(context).resultAcssPrice!=0

          )  {
            BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumAccessories(b: false) ;
            print("success 3 ");

            BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForAccessories(
              other_color:"" ,
                color_id: "",
                context: context,
                album_type: "4",
                accessories_type: BlocProvider.of<ListsCubit>(context)
                    .accessoriesTypeForFiller
                    ?.id ??
                    "",
                description: BlocProvider.of<ListsCubit>(context)
                    .descriptionForAccessories,
                album_price: BlocProvider.of<ListsCubit>(context)
                    .resultAcssPrice
                    .toString(),
                accessories_type_board:"",
                accessories_type_print:
                BlocProvider.of<ListsCubit>(context)
                    .printSize
                    ?.id
                    .toString() ??
                    "",
                couple_name:"" ,
                drilling_type_id:"",
                with_date:"",
                date:""
            ) ;

          }else if (
          BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller?.id=="4"
          &&
              BlocProvider.of<ListsCubit>(context).nameOfCouplesForAccessories.isNotEmpty
          &&
              BlocProvider.of<ListsCubit>(context).drillingType?.id!=-1
          &&


              (
                  BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id=="1"
                  &&
                      BlocProvider.of<ListsCubit>(context).historyDateForAccessories.isNotEmpty
                  ||BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id=="0"
              ) &&
              BlocProvider.of<ListsCubit>(context).resultAcssPrice!=0


          ){
            BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumAccessories(b: false) ;
            print("success 3 ");

            BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForMagazine(
              other_color:BlocProvider.of<ListsCubit>(context).anotherColorTextForAccessories,
                color_id:BlocProvider.of<ListsCubit>(context).colorForAccessories?.id.toString()??"",
                context: context,
                album_type: "4",
                accessories_type: BlocProvider.of<ListsCubit>(context)
                    .accessoriesTypeForFiller
                    ?.id ??
                    "",
                description: BlocProvider.of<ListsCubit>(context)
                    .descriptionForAccessories,
                album_price: BlocProvider.of<ListsCubit>(context)
                    .resultAcssPrice
                    .toString(),
                accessories_type_board:"",
                accessories_type_print:"",
                couple_name:
                BlocProvider.of<ListsCubit>(context).nameOfCouplesForAccessories,
                drilling_type_id:BlocProvider.of<ListsCubit>(context).drillingType?.id.toString() ?? "",
                with_date:


                BlocProvider.of<ListsCubit>(context).historyOfAccessories?.id ?? "",
                date:
                BlocProvider.of<ListsCubit>(context).historyDateForAccessories
            ) ;

          }else{
            BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumAccessories(b: true) ;

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


