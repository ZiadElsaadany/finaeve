import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/shared_widgets/warning_template.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../models/list_models.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../widgets/album_order_widgets/end_order_screen_details.dart';
import '../../widgets/album_order_widgets/text_align.dart';
import '../../widgets/shared_widgets/text_input_template.dart';
class PaintOrderScreen extends StatelessWidget {
  const PaintOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ListsCubit, ListsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        TextAlignForRequestAlbum(title:  tr(StringConstants.sendPanel)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        const WayToUploadPhotoPaintAlbum(),



        BlocProvider.of<ListsCubit>(context).emptyOrNotInAlbumLPaint &&
            BlocProvider.of<ListsCubit>(context).painting?.id==""?
        TextAlignForRequestAlbum(

            color:Colors.red,
            title:  tr(StringConstants.noWaysImages)):const SizedBox(),


        const SizedBox(
          height: 10,
        ),
        BlocProvider.of<ListsCubit>(context).painting?.id == "1"
            ? Column(
          children: [
            TextFormField(
              onChanged: (ct) {
                BlocProvider.of<ListsCubit>(context).setUrlForAlbumWithPaint(ct.trim());

              },

              initialValue:  BlocProvider.of<ListsCubit>(context).urlForAlbumWithPaint,
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
            BlocProvider.of<ListsCubit>(context).emptyOrNotInAlbumLPaint &&
                BlocProvider.of<ListsCubit>(context).urlForAlbumWithPaint.isEmpty?
          TextAlignForRequestAlbum(title: tr(StringConstants.noUrl),
              color: Colors.red,
            ) :   const SizedBox()
          ],
        )
            : BlocProvider.of<ListsCubit>(context).painting?.id == "2"
            ? Center(
              child: Column(
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
                        .selectedFileForPaint !=
                        null)
                      SelectedFileWidget(
                          file:
                          BlocProvider.of<ListsCubit>(context)
                              .selectedFileForPaint!),

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
                                  .changeSelectedFileFprAlbumWithPaintFile(
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
        ),
            )
            : const SizedBox(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),


        BlocProvider.of<ListsCubit>(context).emptyOrNotInAlbumLPaint &&
            BlocProvider.of<ListsCubit>(context).painting?.id=="2"

            && BlocProvider.of<ListsCubit>(context).selectedFileForPaint==null
    ?
    TextAlignForRequestAlbum(title: tr(StringConstants.noFilePaint),
    color: Colors.red,
    ): const SizedBox(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),


        TextInputTemplate(
            initialValue: BlocProvider.of<ListsCubit>(context)
                .descriptionForAlbumWithPaint,
            onChanged: (c) {
              BlocProvider.of<ListsCubit>(context)
                  .changeDescriptionForAlbumWithPaint(c.trim());


            },
            headerTxt: tr(StringConstants.theNotes),
            hintText: tr(StringConstants.notes)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

      ],
    );
  },
);
  }
}

class WayToUploadPhotoPaintAlbum extends StatefulWidget {
  const WayToUploadPhotoPaintAlbum({Key? key}) : super(key: key);

  @override
  State<WayToUploadPhotoPaintAlbum> createState() => _WayToUploadPhotoPaintAlbumState();
}

class _WayToUploadPhotoPaintAlbumState extends State<WayToUploadPhotoPaintAlbum> {
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
                    .painting
                    ?.name ??
                    "",
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changePainting(newValue!);
                  setState(() {

                  });


                },

                items: List<BaseIdNameModel>.from(context
                    .read<ListsCubit>()






                    .listOfPainting!
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
                ).toList() ,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SendRequestPaint extends StatelessWidget {
  const SendRequestPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {
        // TODO: implement listener

        print("state hanges");

        if(state is SendRequestForPrintWithPaintSuccessStates) {
          debugPrint("success");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message)));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
            return CartScreen();
          }));
        }
        else if(state is SendRequestForPrintWithPaintFailureStates) {
          debugPrint("failure");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }

      },
      builder: (context, state) {

        return   state is SendRequestForPrintWithPaintLoadingStates ?
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
                    debugPrint( "${ BlocProvider.of<ListsCubit>(context).urlForAlbumWithPaint}");
                    debugPrint( "${BlocProvider.of<ListsCubit>(context).emptyOrNotInAlbumLPaint}");
                    debugPrint( "Send Paint");
                    if(
                    BlocProvider.of<ListsCubit>(context).painting!.id!=""
                    ){
                      if(
                      BlocProvider.of<ListsCubit>(context).painting!.id=="1"&&
                          BlocProvider.of<ListsCubit>(context).urlForAlbumWithPaint.isNotEmpty
                      ) {

                        BlocProvider.of<ListsCubit>(context).updateEmptyOrNotInAlbumLPaint(b: false);

                            BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithPaint(
                            context: context,
                            album_type: "5",
                            url:
                            BlocProvider.of<ListsCubit>(context).urlForAlbumWithPaint,
                            image:null ,

                            description: BlocProvider.of<ListsCubit>(context)
                                .descriptionForAlbumWithPaint

                        );
                      }else  if(
                      BlocProvider.of<ListsCubit>(context).painting!.id=="2"
                          && BlocProvider.of<ListsCubit>(context).selectedFileForPaint!=null

                      ) {

                        BlocProvider.of<ListsCubit>(context).updateEmptyOrNotInAlbumLPaint(b: false);

                        BlocProvider.of<AlbumDetailsRowCubit>(context).sendRequestForPrintWithPaint(
                            context: context,
                            album_type: "5",
                            url:"",
                            image:
                            BlocProvider.of<ListsCubit>(context).selectedFileForPaint,

                            description: BlocProvider.of<ListsCubit>(context)
                                .descriptionForAlbumWithPaint

                        );
                      }
                    else{
                      BlocProvider.of<ListsCubit>(context).updateEmptyOrNotInAlbumLPaint(b: true);

                    }

                    }
                    else{
                      BlocProvider.of<ListsCubit>(context).updateEmptyOrNotInAlbumLPaint(b: true);

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
