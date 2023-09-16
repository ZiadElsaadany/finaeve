import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/album_order/album_details_row_cubit.dart';
import '/peresentation/widgets/shared_widgets/text_input_template.dart';
import '/peresentation/widgets/shared_widgets/warning_template.dart';
import '/utilities/constants/string_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/photos.dart';
import '../../models/list_models.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../widgets/album_order_widgets/drop_down_button.dart';
import '../../widgets/album_order_widgets/end_order_screen_details.dart';
import '../../widgets/album_order_widgets/text_align.dart';

class PrintWithFillerScreen extends StatefulWidget {
  const PrintWithFillerScreen({Key? key}) : super(key: key);

  @override
  State<PrintWithFillerScreen> createState() => _PrintWithFillerScreenState();
}

class _PrintWithFillerScreenState extends State<PrintWithFillerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ListsCubit, ListsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
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
                ///sizes

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    TextAlignForRequestAlbum(
                        title: tr(StringConstants.theSizes)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const SizesDropDownWidgetForSizesScreenFoFiller(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&
                        BlocProvider.of<ListsCubit>(context).currentSizeForFillerAlbum?.id==-1?
                    TextAlignForRequestAlbum(
                        color: Colors.red,
                        title: tr(StringConstants.noSize)):const SizedBox(),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                ///pages


                    const PagesForAlbumWithPrint(),

                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&     BlocProvider.of<ListsCubit>(context).pagesForFiller?.id==""?
                    TextAlignForRequestAlbum(
                        color: Colors.red,

                        title: tr(StringConstants.noPages)):const SizedBox(),
                    /// process or not
                    ///
                    ///
                    ///
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const ProcessOrNotForAlbumWithPrint(),

                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&     BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id==""?
                    TextAlignForRequestAlbum(
                        color: Colors.red,

                        title: tr(StringConstants.noWithProcess)):const SizedBox(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                    //design or notes
                    context.read<ListsCubit>().withProcessOrNotForFiller?.id == "1"
                        ? Column(
                      children: [
                        TextInputTemplate(
                            onChanged: (value) {
                              BlocProvider.of<ListsCubit>(context)
                                  .setNotesForDesignForFiller(value);

                            },
                            initialValue:   BlocProvider.of<ListsCubit>(context).notesForDesignForFiller,
                            headerTxt: tr(StringConstants.editNotes),
                            hintText: tr(StringConstants.notes)),
                        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&    BlocProvider.of<ListsCubit>(context).notesForDesignForFiller.isEmpty?
                        TextAlignForRequestAlbum(
                            color: Colors.red,

                            title: tr(StringConstants.noNotes)):const SizedBox()
                      ],
                    )
                        :context.read<ListsCubit>().withProcessOrNotForFiller?.id == "0"?
                    Column(
                      children: [
                        DropDownButtonTemplate(
                          text: tr(StringConstants.pagesDesigner),
                          items: context
                              .read<ListsCubit>()
                              .listDesignOrNotForAlbumWithPrint??
                              [],
                          value: context
                              .read<ListsCubit>()
                              .withDesignForFiller
                              ?.name,
                          onChanged: (value) {
                            BlocProvider.of<ListsCubit>(context)
                                .changeDesignOrNotForFiller(value!);
                            BlocProvider.of<ListsCubit>(context).funGetPrice(context);


                          },
                        ),
                        BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&    BlocProvider.of<ListsCubit>(context).withDesignForFiller?.id==""?
                        TextAlignForRequestAlbum(
                            color: Colors.red,

                            title: tr(StringConstants.noNotes)):const SizedBox()
                      ],
                    ):const SizedBox(),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                ///with pricess or not
                    ///
                    ///
                    ///yes      with note for process
                    ///
                    ///no       with design

              /// way to upload photo


              ///paper type

              /// description
                    TextAlignForRequestAlbum(title:  tr(StringConstants.wayToUploadPhotos)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const WayToUploadPhotoAlbumWithPrint(),



                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&  BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id==""?
                    TextAlignForRequestAlbum(

                        color:Colors.red,
                        title:  tr(StringConstants.noWaysImages)):const SizedBox(),


                    const SizedBox(
                      height: 10,
                    ),
                    BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id == "2" ||
                        BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id == "3"
                        ? Column(
                      children: [
                        TextFormField(
                          onChanged: (ct) {
                            BlocProvider.of<ListsCubit>(context).setUrlForFiller(ct.trim());
                            print(BlocProvider.of<ListsCubit>(context).urlForFiller);
                          },

                          initialValue:  BlocProvider.of<ListsCubit>(context).urlForFiller,
                          cursorColor: MyColors.primaryColor,
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                          ),
                        ),
                        BlocProvider.of<ListsCubit>(context).urlForFiller.isNotEmpty?
                        const SizedBox():TextAlignForRequestAlbum(title: tr(StringConstants.noUrl),
                          color: Colors.red,
                        )
                      ],
                    )
                        : BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id == "4"
                        ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                              color: MyColors.myGray.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Display the selected file widget if a file is selected
                              if (BlocProvider.of<ListsCubit>(context)
                                  .selectedFileForFiller !=
                                  null)
                                SelectedFileWidget(
                                    file:
                                    BlocProvider.of<ListsCubit>(context)
                                        .selectedFileForFiller!),

                              // Show a button to select a file
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                color: MyColors.primaryColor,
                                onPressed: () async {
                                try{
                                  FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['zip', 'rar'],
                                  );

                                  if (result != null) {
                                    String? path = result.files.single.path;
                                    if(path!=null) {
                                      BlocProvider.of<ListsCubit>(context)
                                          .changeSelectedFileForFillerFile(
                                          File(
                                              result.files.single.path!));
                                    }else{
                                      print(path.toString());
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                          tr( StringConstants.problemMessageInCubit)
                                      )));
                                    }
                                    // Update the UI to display the selected file
                                  }
                                }catch(e)   {
                                  print(e.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                                     tr( StringConstants.problemMessageInCubit)
                                  )));
                                }
                                },
                                child:  Text(
                                  tr(StringConstants.selectFile),
                                  style: const TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.015),
                        const WarningTemplate(),
                      ],
                    )
                        : const SizedBox(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextAlignForRequestAlbum(title: tr(StringConstants.paperType)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const TypeOfPaperScreen(),
                    BlocProvider.of<ListsCubit>(context).emptyOrNotPage1InAlbumFiller &&     BlocProvider.of<ListsCubit>(context).paperTypeForFiller?.id==-1?
                    TextAlignForRequestAlbum(
                        color: Colors.red,
                        title: tr(StringConstants.noPaper)):const SizedBox(),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    TextInputTemplate(
                        initialValue: BlocProvider.of<ListsCubit>(context)
                            .descriptionForFiller,
                        onChanged: (c) {
                          BlocProvider.of<ListsCubit>(context)
                              .changeDescriptionForFiller(c.trim());


                        },
                        headerTxt: tr(StringConstants.theNotes),
                        hintText: tr(StringConstants.notes)),
        ]
    )
    ) ; } )
    ] );
  }
}

// class SendFillerRequest extends StatelessWidget {
//   const SendFillerRequest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
//         builder: (ctx, state) {
//           return state is SendRequestForPrintWithFillerLoadingStates
//               ? const CircularProgressIndicator(
//                   color: MyColors.primaryColor,
//                 )
//               : MaterialButton(
//                   onPressed: () {
//                     BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithFillerScreen(
//                         album_type: (BlocProvider.of<AlbumDetailsRowCubit>(context)
//                                     .indexOfSelectedRequestOfAlbum +
//                                 1)
//                             .toString(),
//                         size_id: BlocProvider.of<ListsCubit>(context)
//                                 .currentSizeForFillerAlbum
//                                 ?.id
//                                 .toString() ??
//                             "",
//                         number_of_page: BlocProvider.of<ListsCubit>(context)
//                                 .pagesForFiller
//                                 ?.id
//                                 .toString() ??
//                             "",
//                         with_process: BlocProvider.of<ListsCubit>(context)
//                                 .withProcessOrNotForFiller
//                                 ?.id
//                                 .toString() ??
//                             "",
//                         image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id ??
//                             "",
//                         paper_type_id: BlocProvider.of<ListsCubit>(context)
//                                 .paperTypeForFiller
//                                 ?.id
//                                 .toString() ??
//                             "",
//                         description: BlocProvider.of<ListsCubit>(context).descriptionForFiller,
//                         album_price:BlocProvider.of<ListsCubit>(context).albumPriceForFiller.toString() ,
//                         processing_note: BlocProvider.of<ListsCubit>(context).notesForDesignForFiller,
//                         url: BlocProvider.of<ListsCubit>(context).urlForFiller,
//                         image: BlocProvider.of<ListsCubit>(context).selectedFileForFiller,
//                         context: context);
//                   },
//                   minWidth: MediaQuery.of(context).size.width,
//                   textColor: MyColors.myWhite,
//                   color: MyColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Text(tr(StringConstants.addOrderToCart)),
//                 );
//         },
//         listener: (ctx, state) {});
//   }
// }
//

class SizesDropDownWidgetForSizesScreenFoFiller extends StatelessWidget {
  const SizesDropDownWidgetForSizesScreenFoFiller({Key? key}) : super(key: key);

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
                        .currentSizeForFillerAlbum
                        ?.nameEng ??
                        ""
                        : BlocProvider.of<ListsCubit>(context)
                        .currentSizeForFillerAlbum
                        ?.name ??
                        "",
                    onChanged: (newValue) {
                      BlocProvider.of<ListsCubit>(context)
                          .changeCurrentSizeForFiller(newValue!);
                      BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                      debugPrint(
                          "id size Of AlbumWithPrint ${BlocProvider.of<ListsCubit>(context).currentSizeForFillerAlbum?.id ?? ""}");
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
class PagesForAlbumWithPrint extends StatelessWidget {
  const PagesForAlbumWithPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return             BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DropDownButtonTemplate(
          items:
          context.read<ListsCubit>().listOfPagesForAlbumWithPrint?? [],
          text: tr(
            StringConstants.pagesNum,
          ),
          value: context.read<ListsCubit>().pagesForFiller?.name,
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changePagesWithAFiller(value!);
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
    return                     BlocConsumer<ListsCubit, ListsState>(
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
          value: BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.name,
          onChanged: (value) {
            BlocProvider.of<ListsCubit>(context)
                .changeProcessForFiller(value!);
            BlocProvider.of<ListsCubit>(context).funGetPrice(context);

          },
        );
      },
    );
  }
}


class WayToUploadPhotoAlbumWithPrint extends StatefulWidget {
  const WayToUploadPhotoAlbumWithPrint({Key? key}) : super(key: key);

  @override
  State<WayToUploadPhotoAlbumWithPrint> createState() => _WayToUploadPhotoAlbumWithPrintState();
}

class _WayToUploadPhotoAlbumWithPrintState extends State<WayToUploadPhotoAlbumWithPrint> {
  @override
  Widget build(BuildContext context) {
    return     Container(
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
                    .wayToUploadPhotoForFiller
                    ?.name ??
                    "",
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeWayToUploadPhotoForfFiller(newValue!);
                  BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                  setState(() {

                  });


                },

                items: List<BaseIdNameModel>.from(context
                    .read<ListsCubit>()
                    .lstWayToUploadPhotoWithPrint!
                  // .map((e) => BaseIdNameModel(
                  //     e.id.toString(), e.name))
                )
                    .map<DropdownMenuItem<String>>(
                      (item) {
                    return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(item.name,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.myBlack,
                        fontSize: 14,
                      ),),
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
  }
}
class TypeOfPaperScreen extends StatefulWidget {
  const TypeOfPaperScreen({Key? key}) : super(key: key);

  @override
  State<TypeOfPaperScreen> createState() => _TypeOfPaperScreenState();
}

class _TypeOfPaperScreenState extends State<TypeOfPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return   Container(
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
                    .paperTypeForFiller
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changePaperTypeForFiller(newValue!);

                  BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                  setState(() {

                  });
                },

                items: List<PaperType>.from(context
                    .read<ListsCubit>()
                    .lstPaperTypeForAlbumWithPrint!
                  // .map((e) => BaseIdNameModel(
                  //     e.id.toString(), e.name))
                )
                    .map<DropdownMenuItem<String>>(
                      (item) {
                    return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(item.name,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.myBlack,
                        fontSize: 14,
                      ),),
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
  }
}



// send request for filler
class SendRequestForFiller extends StatelessWidget {
  const SendRequestForFiller({Key? key}) : super(key: key);


  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {
        // TODO: implement listener

        if(state is SendRequestForPrintWithFillerFailureStates) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }
        else   if(state is SendRequestForPrintWithFillerSuccessStates) {
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

        return   state is SendRequestForPrintWithFillerLoadingStates ?
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
                  onPressed: ( ) {

                    if(

                    BlocProvider.of<ListsCubit>(context).currentSizeForFillerAlbum?.id!=-1 &&
                    BlocProvider.of<ListsCubit>(context).pagesForFiller?.id!="" &&
                        BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id!=""

                       &&

                        BlocProvider.of<ListsCubit>(context).paperTypeForFiller?.id!=-1
                    &&
                        (
                            BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id=="1"
&& BlocProvider.of<ListsCubit>(context).notesForDesignForFiller.isNotEmpty
                            ||
                                BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id=="0"&&
                                BlocProvider.of<ListsCubit>(context).withDesignForFiller?.id!=""
                        ) &&
                    BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id!=""
                     ) {
                      if(BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id== "1"
                      || BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id== "5"
                      ) {
                        BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumFiller(b: false);

                        BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithFillerScreen(
                          with_design  :
                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="0"?
                          BlocProvider.of<ListsCubit>(context).withDesignForFiller!.id :""
                          ,
                          image:BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id=="4"?
                          BlocProvider.of<ListsCubit>(context).selectedFileForFiller :null,
                          image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id??"",
                          number_of_page: BlocProvider.of<ListsCubit>(context).pagesForFiller?.id??"",
                          paper_type_id:  BlocProvider.of<ListsCubit>(context).paperTypeForFiller?.id.toString()??"",
                          processing_note:

                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="1"?
                          BlocProvider.of<ListsCubit>(context).notesForDesignForFiller:"",

                          url:
                          BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="2"
                              ||                    BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="3"?
                          BlocProvider.of<ListsCubit>(context).urlForFiller??"" :"",
                          with_process:  BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id??"",

                          context: context,
                          album_type: (BlocProvider
                              .of<AlbumDetailsRowCubit>(context)
                              .indexOfSelectedRequestOfAlbum +
                              1)
                              .toString(),
                          size_id:
                          BlocProvider
                              .of<ListsCubit>(context)
                              .currentSizeForFillerAlbum
                              ?.id
                              .toString() ?? "",


                          //
                          description: BlocProvider
                              .of<ListsCubit>(context)
                              .descriptionForFiller,
                          // BlocProvider
                          //             .of<ListsCubit>(context)
                          //             .albumPrice
                          //             .toString()
                          album_price:BlocProvider.of<ListsCubit>(context).albumPriceForFiller.toString(),
                          //


                        );



                      }else if  (
                      (
                      BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id== "2" &&
                          BlocProvider.of<ListsCubit>(context).urlForFiller.isNotEmpty
                      )
                    ||   (
                          BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id== "3" &&
                              BlocProvider.of<ListsCubit>(context).urlForFiller.isNotEmpty
                      )
                      ) {
                        BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumFiller(b: false);

                        BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithFillerScreen(
                          with_design  :
                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="0"?
                          BlocProvider.of<ListsCubit>(context).withDesignForFiller!.id :""
                          ,
                          image:BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id=="4"?
                          BlocProvider.of<ListsCubit>(context).selectedFileForFiller :null,
                          image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id??"",
                          number_of_page: BlocProvider.of<ListsCubit>(context).pagesForFiller?.id??"",
                          paper_type_id:  BlocProvider.of<ListsCubit>(context).paperTypeForFiller?.id.toString()??"",
                          processing_note:

                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="1"?
                          BlocProvider.of<ListsCubit>(context).notesForDesignForFiller:"",

                          url:
                          BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="2"
                              ||                    BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="3"?
                          BlocProvider.of<ListsCubit>(context).urlForFiller??"" :"",
                          with_process:  BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id??"",

                          context: context,
                          album_type: (BlocProvider
                              .of<AlbumDetailsRowCubit>(context)
                              .indexOfSelectedRequestOfAlbum +
                              1)
                              .toString(),
                          size_id:
                          BlocProvider
                              .of<ListsCubit>(context)
                              .currentSizeForFillerAlbum
                              ?.id
                              .toString() ?? "",


                          //
                          description: BlocProvider
                              .of<ListsCubit>(context)
                              .descriptionForFiller,
                          // BlocProvider
                          //             .of<ListsCubit>(context)
                          //             .albumPrice
                          //             .toString()
                          album_price:BlocProvider.of<ListsCubit>(context).albumPriceForFiller.toString(),
                          //


                        );




                      }else if(BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id== "4" &&
                          BlocProvider.of<ListsCubit>(context).selectedFileForFiller!=null
                          ) {
                        BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumFiller(b: false);

                        BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithFillerScreen(
                          with_design  :
                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="0"?
                          BlocProvider.of<ListsCubit>(context).withDesignForFiller!.id :""
                          ,
                          image:BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id=="4"?
                          BlocProvider.of<ListsCubit>(context).selectedFileForFiller :null,
                          image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller?.id??"",
                          number_of_page: BlocProvider.of<ListsCubit>(context).pagesForFiller?.id??"",
                          paper_type_id:  BlocProvider.of<ListsCubit>(context).paperTypeForFiller?.id.toString()??"",
                          processing_note:

                          BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller!.id=="1"?
                          BlocProvider.of<ListsCubit>(context).notesForDesignForFiller:"",

                          url:
                          BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="2"
                              ||                    BlocProvider.of<ListsCubit>(context).wayToUploadPhotoForFiller!.id =="3"?
                          BlocProvider.of<ListsCubit>(context).urlForFiller??"" :"",
                          with_process:  BlocProvider.of<ListsCubit>(context).withProcessOrNotForFiller?.id??"",

                          context: context,
                          album_type: (BlocProvider
                              .of<AlbumDetailsRowCubit>(context)
                              .indexOfSelectedRequestOfAlbum +
                              1)
                              .toString(),
                          size_id:
                          BlocProvider
                              .of<ListsCubit>(context)
                              .currentSizeForFillerAlbum
                              ?.id
                              .toString() ?? "",


                          //
                          description: BlocProvider
                              .of<ListsCubit>(context)
                              .descriptionForFiller,
                          // BlocProvider
                          //             .of<ListsCubit>(context)
                          //             .albumPrice
                          //             .toString()
                          album_price:BlocProvider.of<ListsCubit>(context).albumPriceForFiller.toString(),
                          //


                        );




                      }

                    }else {
                      BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage1InAlbumFiller(b: true);
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
