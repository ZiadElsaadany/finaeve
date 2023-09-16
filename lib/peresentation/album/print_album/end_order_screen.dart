import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/business_logic/album_order/album_details_row_cubit.dart';
import '/peresentation/widgets/album_order_widgets/end_order_screen_details.dart';
import '/utilities/constants/string_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/constants/colors.dart';
import '../../screens/cart_screen/cart_screen.dart';


class EndOrderScreen extends StatelessWidget {
  const EndOrderScreen({Key? key}) : super(key: key);
  static const String id = 'end order';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
              MediaQuery.of(context).size.width * 0.04,
              vertical:
              MediaQuery.of(context).size.height * 0.01),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.005),
               const EndOrderScreenDetails(),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.05),
            ],
          ),
        ),

        SizedBox(
            height: MediaQuery.of(context).size.height * 0.01),

      ],
    );
  }
}

class NextFormPage4FromAlbumWithPrint extends StatelessWidget {
  const NextFormPage4FromAlbumWithPrint({Key? key}) : super(key: key);


  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
  listener: (context, state) {
    // TODO: implement listener

    if(state is SendRequestFailureStates) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(state.message)));
    }
 else   if(state is SendRequestSuccessStates) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(state.message)));
    }
  },
  builder: (context, state) {

    return   state is SendRequestLoadingStates?
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
              BlocProvider.of<AlbumDetailsRowCubit>(context).minusIndexOfSelectedRequestOfAlbum();
            } ,
            icon : const Icon(
            Icons.arrow_back_ios ) ,
          ),

          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.all(15),
              color: MyColors.primaryColor,
              textColor: Colors.white,
              onPressed:                     ( ) {
               debugPrint("modal image: ${
                   BlocProvider
                       .of<ListsCubit>(context)
                       .modelImageForWithPrint
                       ?.id.toString()}") ;debugPrint("number : ${ BlocProvider
                   .of<ListsCubit>(context)
                   .pagesForAlbumWithPrint
                   ?.id ?? ""
                   .toString() }") ;


             if(      BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint?.id!=-1 &&
                 BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id!="" &&
             BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithPrint!=0
             )  {
               if(BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id=="1"
               || BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id=="5"
               ){
                 BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage4InAlbumWithPrint(b:
                 false
                 );
                 debugPrint(BlocProvider
                     .of<ListsCubit>(context)
                     .miniForAlbumWithPrint.toString());

                 BlocProvider.of<AlbumDetailsRowCubit>(context).sendAlbumRequestWithPrint(
                     with_design:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="0" ?
                     BlocProvider
                         .of<ListsCubit>(context).withDesignForAlbumWithPrint!.id   :""
                     ,
                     context: context,

                     cover_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint!.id==4?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .coverTypeForAlbumPrint
                         ?.id
                         .toString() ?? "" : ""


                     ,
                     album_type: (BlocProvider
                         .of<AlbumDetailsRowCubit>(context)
                         .indexOfSelectedRequestOfAlbum +
                         1)
                         .toString(),
                     size_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .currentSizeForPrintAlbum
                         ?.id
                         .toString() ?? "",
                     box: BlocProvider
                         .of<ListsCubit>(context)
                         .boxYesOrNoAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_extension: BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint
                         ?.id ?? ""
                         .toString(),
                     number_of_page:BlocProvider
                         .of<ListsCubit>(context)
                         .pagesForAlbumWithPrint
                         ?.id ?? ""
                         .toString() ,
                     with_process: BlocProvider
                         .of<ListsCubit>(context)
                         .withProcessOrNotForAlbumWithPrint
                         ?.id ?? ""
                         .toString(),

                     album_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",


                     color_id: BlocProvider
                         .of<ListsCubit>(context)
                         .colorForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     corner_id: BlocProvider
                         .of<ListsCubit>(context)
                         .cornerForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_open_flash:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .withUsbForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     couple_name: BlocProvider
                         .of<ListsCubit>(context)
                         .nameOfCouplesForAlbumPrint,
                     drilling_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .drillingTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_date: BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint
                         ?.id ?? "",
                     side_image: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id.toString() ?? "",
                     image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id.toString(),
                     paper_type_id: BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint!.id.toString(),
                     //
                     description: BlocProvider
                         .of<ListsCubit>(context)
                         .descriptionForAlbumWithPrint,
                     // BlocProvider
                     //             .of<ListsCubit>(context)
                     //             .albumPrice
                     //             .toString()
                     album_price:BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithPrint.toString(),
                     //
                     model_image:

                     BlocProvider
                         .of<ListsCubit>(context).boxYesOrNoAlbumWithPrint?.id=="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .modelImageForWithPrint
                         ?.id.toString() ?? "":"",
                     album_model: BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithPrint,
                     extension_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint!.id =="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .miniForAlbumWithPrint: ""  ,
                     processing_note:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="1" ?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .notesForDesignForAlbumWithPrint : "",
                     other_color: BlocProvider
                         .of<ListsCubit>(context)
                         .anotherColorTextForPrintAlbum,
                     date:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint!.id == "1"?

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyDateForAlbumWithPrint  : ""


                     ,
                     side_image_size:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"?
                     BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint?.id.toString()??"":
                     ""
                     ,



                     number: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"? BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint: "",


                     url:  BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="2" ||
                         BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="3"
                         ?
                     BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint :
                     ""
                     ,
                     image:
                     BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="4" ?
                     BlocProvider.of<ListsCubit>(context).selectedFileFprAlbumWithPrint
                         :null

                 ).then((value)   {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
                     return CartScreen();
                   }));
                 });


               }else if( BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id=="2" ||
                   BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id=="3"
               &&
                       BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint.isNotEmpty

               )  {
                 BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage4InAlbumWithPrint(b:
                 false
                 );
                 debugPrint(BlocProvider
                     .of<ListsCubit>(context)
                     .miniForAlbumWithPrint.toString());
                 BlocProvider.of<AlbumDetailsRowCubit>(context).sendAlbumRequestWithPrint(

                     with_design:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="0" ?
                     BlocProvider
                         .of<ListsCubit>(context).withDesignForAlbumWithPrint!.id   :""
                     ,
                     context: context,

                     cover_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint!.id==4?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .coverTypeForAlbumPrint
                         ?.id
                         .toString() ?? "" : ""


                     ,
                     album_type: (BlocProvider
                         .of<AlbumDetailsRowCubit>(context)
                         .indexOfSelectedRequestOfAlbum +
                         1)
                         .toString(),
                     size_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .currentSizeForPrintAlbum
                         ?.id
                         .toString() ?? "",
                     box: BlocProvider
                         .of<ListsCubit>(context)
                         .boxYesOrNoAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_extension: BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint
                         ?.id ?? ""
                         .toString(),
                     number_of_page:BlocProvider
                         .of<ListsCubit>(context)
                         .pagesForAlbumWithPrint
                         ?.id ?? ""
                         .toString() ,
                     with_process: BlocProvider
                         .of<ListsCubit>(context)
                         .withProcessOrNotForAlbumWithPrint
                         ?.id ?? ""
                         .toString(),

                     album_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",


                     color_id: BlocProvider
                         .of<ListsCubit>(context)
                         .colorForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     corner_id: BlocProvider
                         .of<ListsCubit>(context)
                         .cornerForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_open_flash:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .withUsbForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     couple_name: BlocProvider
                         .of<ListsCubit>(context)
                         .nameOfCouplesForAlbumPrint,
                     drilling_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .drillingTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_date: BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint
                         ?.id ?? "",
                     side_image: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id.toString() ?? "",
                     image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id.toString(),
                     paper_type_id: BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint!.id.toString(),
                     //
                     description: BlocProvider
                         .of<ListsCubit>(context)
                         .descriptionForAlbumWithPrint,
                     // BlocProvider
                     //             .of<ListsCubit>(context)
                     //             .albumPrice
                     //             .toString()
                     album_price:BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithPrint.toString(),
                     //
                     model_image:

                     BlocProvider
                         .of<ListsCubit>(context).boxYesOrNoAlbumWithPrint?.id=="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .modelImageForWithPrint
                         ?.id.toString() ?? "":"",
                     album_model: BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithPrint,
                     extension_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint!.id =="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .miniForAlbumWithPrint: ""  ,
                     processing_note:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="1" ?         BlocProvider
                         .of<ListsCubit>(context)
                         .notesForDesignForAlbumWithPrint : "",
                     other_color: BlocProvider
                         .of<ListsCubit>(context)
                         .anotherColorTextForPrintAlbum,
                     date:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint!.id == "1"?

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyDateForAlbumWithPrint  : ""


                     ,
                     side_image_size:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"?
                     BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint?.id.toString()??"":
                     ""
                     ,



                     number: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"? BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint: "",


                     url:  BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="2" ||
                         BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="3"
                     ?
                     BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint :
                     ""
                     ,
                     image:
                     BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="4" ?
                         BlocProvider.of<ListsCubit>(context).selectedFileFprAlbumWithPrint
                 :null

                 ).then((value)   {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
                     return CartScreen();
                   }));
                 });

               }
               else if(BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id=="4"&&
                   BlocProvider.of<ListsCubit>(context).selectedFileFprAlbumWithPrint!=null
               ) {
                 BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage4InAlbumWithPrint(b:
                 false
                 );

                 BlocProvider.of<AlbumDetailsRowCubit>(context).sendAlbumRequestWithPrint(
                     with_design:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="0" ?
                     BlocProvider
                         .of<ListsCubit>(context).withDesignForAlbumWithPrint!.id   :""
                     ,
                     context: context,

                     cover_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint!.id==4?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .coverTypeForAlbumPrint
                         ?.id
                         .toString() ?? "" : ""


                     ,
                     album_type: (BlocProvider
                         .of<AlbumDetailsRowCubit>(context)
                         .indexOfSelectedRequestOfAlbum +
                         1)
                         .toString(),
                     size_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .currentSizeForPrintAlbum
                         ?.id
                         .toString() ?? "",
                     box: BlocProvider
                         .of<ListsCubit>(context)
                         .boxYesOrNoAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_extension: BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint
                         ?.id ?? ""
                         .toString(),
                     number_of_page:BlocProvider
                         .of<ListsCubit>(context)
                         .pagesForAlbumWithPrint
                         ?.id ?? ""
                         .toString() ,
                     with_process: BlocProvider
                         .of<ListsCubit>(context)
                         .withProcessOrNotForAlbumWithPrint
                         ?.id ?? ""
                         .toString(),

                     album_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .albumMaterialTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",


                     color_id: BlocProvider
                         .of<ListsCubit>(context)
                         .colorForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     corner_id: BlocProvider
                         .of<ListsCubit>(context)
                         .cornerForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_open_flash:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .withUsbForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     couple_name: BlocProvider
                         .of<ListsCubit>(context)
                         .nameOfCouplesForAlbumPrint,
                     drilling_type_id:
                     BlocProvider
                         .of<ListsCubit>(context)
                         .drillingTypeForAlbumWithPrint
                         ?.id
                         .toString() ?? "",
                     with_date: BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint
                         ?.id ?? "",
                     side_image: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id.toString() ?? "",
                     image_type: BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id.toString(),
                     paper_type_id: BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint!.id.toString(),
                     //
                     description: BlocProvider
                         .of<ListsCubit>(context)
                         .descriptionForAlbumWithPrint,
                     // BlocProvider
                     //             .of<ListsCubit>(context)
                     //             .albumPrice
                     //             .toString()
                     album_price:BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithPrint.toString(),
                     //
                     model_image:

                     BlocProvider
                         .of<ListsCubit>(context).boxYesOrNoAlbumWithPrint?.id=="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .modelImageForWithPrint
                         ?.id.toString() ?? "":"",
                     album_model: BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTOForAlbumWithPrint,
                     extension_type_id:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withExtensionOrNotForWithPrint!.id =="1"?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .miniForAlbumWithPrint: ""  ,
                     processing_note:
                     BlocProvider
                         .of<ListsCubit>(context).withProcessOrNotForAlbumWithPrint?.id =="1" ?
                     BlocProvider
                         .of<ListsCubit>(context)
                         .notesForDesignForAlbumWithPrint : "",
                     other_color: BlocProvider
                         .of<ListsCubit>(context)
                         .anotherColorTextForPrintAlbum,
                     date:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyOfAlbumWithPrint!.id == "1"?

                     BlocProvider
                         .of<ListsCubit>(context)
                         .historyDateForAlbumWithPrint  : ""


                     ,
                     side_image_size:

                     BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"?
                     BlocProvider.of<ListsCubit>(context).sideImageForAlbumWithPrint?.id.toString()??"":
                     ""
                     ,



                     number: BlocProvider
                         .of<ListsCubit>(context)
                         .withFamilyAlbumWithPrint
                         ?.id=="1"? BlocProvider.of<ListsCubit>(context).numOfPhotosForAlbumWithPrint: "",


                     url:  BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="2" ||
                         BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="3"
                         ?
                     BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint :
                     ""
                     ,
                     image:
                     BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint!.id =="4" ?
                     BlocProvider.of<ListsCubit>(context).selectedFileFprAlbumWithPrint
                         :null

                 ).then((value)   {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
                     return CartScreen();
                   }));
                 });


               }


             }else {
               BlocProvider.of<ListsCubit>(context).updateEmptyOrNotPage4InAlbumWithPrint(b:
               true
               );
               print(BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id);
               print(BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint?.id);
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

