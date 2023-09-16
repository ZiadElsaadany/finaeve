import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/peresentation/album/paint_order/paint_order.dart';
import '/peresentation/album/print_album/album_data_screen.dart';
import '/peresentation/album/print_album/album_materials_screen.dart';
import '/peresentation/album/print_album/end_order_screen.dart';
import '/peresentation/album/print_album/print_album_screen.dart';
import '/peresentation/album/print_with_filler/print_with_filler_screen.dart';
import '/peresentation/album/without_print_album/materilas_without_print_screen.dart';
import '/peresentation/album/without_print_album/specifications_details_without_print.dart';
import '/peresentation/album/without_print_album/without_print_album_data.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/widgets/album_order_widgets/album_specification_details.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/album_order/album_details_row_cubit.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/string_constants.dart';
import '../widgets/shared_widgets/album_request_header.dart';
import '../widgets/shared_widgets/header_image.dart';
import '../widgets/shared_widgets/total_prize_template.dart';
import 'accessories_order/accessories_order_screen.dart';
import 'without_print_album/without_print_album_screen.dart';

enum HomeOrNot { home, not }

class AlbumSpecificationScreen extends StatefulWidget {
  const AlbumSpecificationScreen({Key? key, this.home = HomeOrNot.not})
      : super(key: key);
  static const String id = 'album specification';

  final HomeOrNot home;

  @override
  State<AlbumSpecificationScreen> createState() =>
      _AlbumSpecificationScreenState();
}

class _AlbumSpecificationScreenState extends State<AlbumSpecificationScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async{
      await Permission.storage.request();
      await Permission.camera.request();

      BlocProvider.of<ListsCubit>(context).getListsData(context).then((value)  {
        //
        // BlocProvider.of<AlbumDetailsRowCubit>(context)
        //     .restartIndexOfSelectedRequestOfAlbum();

        BlocProvider.of<AlbumDetailsRowCubit>(context).restartAlbumPrintState();
        BlocProvider.of<AlbumDetailsRowCubit>(context)
            .restartIndexOfAlbumWithoutCircleAvatarPrint();
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage1InAlbumWithPrint(b: false);

        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage2InAlbumWithPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage3InAlbumWithPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage4InAlbumWithPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage1InAlbumWithoutPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage2InAlbumWithoutPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage3InAlbumWithoutPrint(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage1InAlbumFiller(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotPage1InAlbumAccessories(b: false);
        BlocProvider.of<ListsCubit>(context)
            .updateEmptyOrNotInAlbumLPaint(b: false);
      } );



    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   OfflineBuilder( connectivityBuilder: (BuildContext context , ConnectivityResult connectivity ,
      Widget child

      ) {
        final bool connected = connectivity!=ConnectivityResult.none;
        if(connected )  {
          return  CustomSpecification(home: widget.home);
        }else{
          return  child;
        }

      },
        child:  NoInternetWidget(
          txt: tr(StringConstants.noInternet),
    ),

      )
    );
  }
}


class CustomSpecification extends StatelessWidget {
  const CustomSpecification({Key? key, required this.home}) : super(key: key);
  final HomeOrNot home;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, listsState) {
        return
          token == null ?
          LoginPage(
            index: 1,
          )
              :

          listsState is ListsLoading
              ? const CircleLoadingByLottie()
              : Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        home == HomeOrNot.home
                            ? const SizedBox()
                            : Stack(
                          children: [
                            const HeaderImage(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: MyColors.myWhite,
                                ))
                          ],
                        ),
                        listsState is ListsLoading
                            ? const Center(child: CircleLoadingByLottie())
                            : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              MediaQuery.of(context).size.width * 0.04,
                              vertical: MediaQuery.of(context).size.height *
                                  0.01),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               AlbumRequestHeader(
                                  index:BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum,
                               ),
                              SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03),

                              /// when change in header
                              BlocProvider.of<AlbumDetailsRowCubit>(
                                  context)
                                  .indexOfSelectedRequestOfAlbum ==
                                  0
                                  ? const PrintAlbumScreen()
                                  : BlocProvider.of<AlbumDetailsRowCubit>(
                                  context)
                                  .indexOfSelectedRequestOfAlbum ==
                                  1
                                  ? const WithoutPrintAlbumScreen()
                                  : BlocProvider.of<AlbumDetailsRowCubit>(
                                  context)
                                  .indexOfSelectedRequestOfAlbum ==
                                  2
                                  ? const PrintWithFillerScreen()
                                  : BlocProvider.of<AlbumDetailsRowCubit>(
                                  context)
                                  .indexOfSelectedRequestOfAlbum ==
                                  3
                                  ? const AccessoriesOrderScreen()
                                  : const PaintOrderScreen()
                            ],
                          ),
                        )


                        ,
                      ],
                    ),

                  ],
                ),
              ),
              BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0),
                        child:

                        TotalPrizeTemplate(
                          number:
                          BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==0?
                          BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithPrint:
                          BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==1?
                          BlocProvider.of<ListsCubit>(context).albumPriceForAlbumWithoutPrint :
                          BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==2?
                          BlocProvider.of<ListsCubit>(context).albumPriceForFiller:
                          BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==3?
                              BlocProvider.of<ListsCubit>(context).accessoriesTypeForFiller!.id=="1"?
                  BlocProvider.of<ListsCubit>(context).boardPrice       :
                          BlocProvider.of<ListsCubit>(context).resultAcssPrice: 0
                          ,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),

                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==0
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint==0?

                      const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            bottom: 15.0,

                        ),
                        child: NextFormPage1FromAlbumWithPrint(),
                      ):
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==0
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint==1?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: NextFormPage2FromAlbumWithPrint(),
                      )

                          : BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==0
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint==2?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: NextFormPage3FromAlbumWithPrint(),
                      ):

                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==0
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint==3?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: Column(
                          children: [
                            NextFormPage4FromAlbumWithPrint(),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                          :
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==1
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumWithoutCircleAvatarPrint==0?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: Column(
                          children: [
                            NextFormPage1FromAlbumWithoutPrint(),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )  :

                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==1
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumWithoutCircleAvatarPrint==1?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: Column(
                          children: [
                            NextFormPage2FromAlbumWithoutPrint(),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                          :
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==1
                          &&  BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumWithoutCircleAvatarPrint==2?
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),
                        child: Column(
                          children: [
                            NextFormPage3FromAlbumWithoutPrint(),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ) :
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==2  ?
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),                  child: Column(
                        children: [
                          SendRequestForFiller(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      )
                          :
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==3 ?
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),                   child: Column(
                        children: [
                          SendRequestAccessories(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      )
                          :
                      BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfSelectedRequestOfAlbum==4 ?
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,

                        ),                  child: Column(
                        children: [
                          SendRequestPaint(),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      ) :


                      SizedBox()

                    ],
                  );
                },
              )
            ],
          );
      },
    );
  }

}
