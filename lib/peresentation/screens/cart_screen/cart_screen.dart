import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evephotography/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/cart/cart_cubit.dart';
import '/peresentation/widgets/album_order_widgets/text_align.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../widgets/FailureWidget.dart';
import '../../widgets/circle_lottie_loading.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/go_to_album.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: customAppBar(context),
        body:  OfflineBuilder(
          connectivityBuilder:
              (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return const CustomCartScreen();
              // widget with initState   -->   apis
            } else {
              return child;
            }
          },
          child: NoInternetWidget(
            txt: tr(StringConstants.noInternet),
          ),
        ),

      );


  }
}

class CustomCartScreen extends StatefulWidget {
  const CustomCartScreen({Key? key}) : super(key: key);

  @override
  State<CustomCartScreen> createState() => _CustomCartScreenState();
}

class _CustomCartScreenState extends State<CustomCartScreen> {
  List keys = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<CartCubit>(context).getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
     print(state);
     if (state is FailureDelCartState) {
       ScaffoldMessenger.of(context)
           .showSnackBar(SnackBar(
         content: Text(state.message),
         backgroundColor: Colors.red,
       ));
     } else if (state
     is SuccessDelCartState) {
       ScaffoldMessenger.of(context)
           .showSnackBar(SnackBar(
         content: Text(state.message),
         backgroundColor: Colors.green,
       ));
       BlocProvider.of<CartCubit>(context).getCart();

     }
     else  if (state is FailureCartState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.message)));
        } else if (state is FailureOrderDoneState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
        }
     else if(state is FailureOrderDoneState){

       showDialog(context: context, builder: (ctx) {
         return SizedBox(
             height: 200,
             child:  DoneOrderDialog(
               id:state.message.split(":")[1],
               message: state.message,
             ));
       });
     }else if(state is SuccessOrderDoneState) {

       showDialog(context: context, builder: (ctx) {
         return SizedBox(
             height: 200,
             child:  DoneOrderDialog(
               id:state.message,
               message: state.message,
             ));
       });
       BlocProvider.of<CartCubit>(context).getCart();

     }
      },
      builder: (context, state) {
        if (state is LoadingCartState) {
          return Center(child: const CircleLoadingByLottie());
        } else {
          return state is FailureCartState ?

        FailureWidget()
        :
            BlocProvider.of<CartCubit>(context).itemList.isEmpty?

                EmptyWidget(
                  text: tr(StringConstants.noItemsInCart),
                )


                :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(StringConstants.cart),
                    textAlign: TextAlign.start,
                    style:
                    const TextStyle(color: MyColors.primaryColor, fontSize: 20),
                  ),
                  Image.asset(
                    ImageConstants.rectangleDesign,
                    width: 23,
                    height: 8,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (ctx,index) {
                    return SizedBox(height: MediaQuery.of(context).size.height*0.03);
                  },
                  padding: EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: BlocProvider.of<CartCubit>(context)
                      .itemList
                      .length,
                  itemBuilder: (ctx, i) {
                    for (var obj
                    in BlocProvider.of<CartCubit>(context)
                        .itemList) {
                      keys = obj.keys.toList();
                      debugPrint(keys.toString());
                      // prints all the values of each object in the list
                    }

                    return Column(
                      children: [
                        ItemOfCart(

                          createdDate: BlocProvider.of<CartCubit>(
                              context)
                              .itemList[i]['created_at'].toString().split(" ")[0]
                              ??"",
                          number: BlocProvider.of<CartCubit>(
                              context)
                              .itemList[i]['id']
                              .toString(),
                          eventDate: BlocProvider.of<CartCubit>(
                              context)
                              .itemList[i]["album_type"]
                              .toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: keys.length,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return BlocProvider.of<CartCubit>(
                                  context)
                                  .itemList[i][keys[index].toString()]
                                  .toString()
                                  .isEmpty ||
                                  BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      '0' ||
                                 keys[index].toString()
                                      .toString()=="album_price"||
                                  BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      'null'|| BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      'لايوجد'||
                                  BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      'لم يحدد' ||
                                  BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      'لم يحدد' ||
                                  keys[index].toString()
                                      .toString()=="model_image" ||
                                  BlocProvider.of<CartCubit>(
                                      context)
                                      .itemList[i][keys[index].toString()]
                                      .toString() ==
                                      'غير يحدد'
                                  ? const SizedBox()
                                  : CustomContainerForDetailsRequest(
                                txt:
                                "${tr(keys[index])}     |    ${
                                    BlocProvider.of<CartCubit>(
                                        context)
                                        .itemList[i][keys[index].toString()]
                                }",
                              );
                            }),
                        BlocProvider.of<CartCubit>(
                            context)
                            .itemList[i]["model_image"]!= ""
                    ?           Column(
                       children: [
                         TextAlignForRequestAlbum(title:tr(StringConstants.model)) ,
                         GestureDetector(
                           onTap: ( ){
                             debugPrint("token is $token");
                           },
                           child: CachedNetworkImage(
                             imageUrl: BlocProvider.of<CartCubit>(
                                 context)
                                 .itemList[i]["model_image"]
                                 .toString(),
                             height: MediaQuery.of(context).size.height*0.3,
                             placeholder: (c,s) {
                               return SizedBox();
                             },
                             errorWidget: (x,r,b) {
                               return Icon(Icons.error);
                             },

                           ),
                         ),
                       ],
                     ):  BlocProvider.of<CartCubit>(
                            context)
                            .itemList[i]["album_model"]!= ""?
                        Column(
                          children: [
                            TextAlignForRequestAlbum(title:tr(StringConstants.model)) ,
                            CachedNetworkImage(
                              imageUrl: BlocProvider.of<CartCubit>(
                                  context)
                                  .itemList[i]["album_model"]
                                  .toString(),
                              height: MediaQuery.of(context).size.height*0.3,
                              placeholder: (c,s) {
                                return SizedBox();
                              },
                              errorWidget: (x,r,b) {
                                return Icon(Icons.error);
                              },

                            ),
                          ],
                        ):SizedBox(),

                        SizedBox(
                          height: 15,
                        ),
                        DeleteItemOnCart(
                          id: BlocProvider.of<CartCubit>(context).itemList[i]["id"].toString(),
                        ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.myYellow,

                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.25,
                          vertical: MediaQuery.of(context).size.height*0.008
                        ),
                        child: Text( "${  BlocProvider.of<CartCubit>(
                            context)
                            .itemList[i]["album_price"]
                            .toString()}   ${tr(StringConstants.SAR)}",
                        style: TextStyle(
                          color: MyColors.myWhite,
                          fontSize: 16
                        ),
                        ),
                      ),

                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 10
              ),
              color: MyColors.myYellow,
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(StringConstants.totalOrder),
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "${BlocProvider.of<CartCubit>(context).totalPrice ?? "0"} ${tr(StringConstants.SAR)}",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            state is LoadingOrderDoneState
                ? Center(
                  child: CircularProgressIndicator(
              color: BlocProvider.of<CartCubit>(context)
                    .itemList
                    .isEmpty
                    ? MyColors.myGray
                    : MyColors.primaryColor,
            ),
                )
                : Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30.0),
              child: MaterialButton(
                onPressed: () {
                  if (BlocProvider.of<CartCubit>(context)
                      .itemList
                      .isEmpty) {
                    return;
                  } else {
                    BlocProvider.of<CartCubit>(context)
                        .orderDone();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: MyColors.myWhite,
                color: MyColors.primaryColor,
                minWidth: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tr(StringConstants.confirmOrder)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:30.0),
              child: RequestAlbumImage(
                imageOrNot: false,
                txt: tr(StringConstants.addingAlbum),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
        }
      },
    );
  }
}

class CustomContainerForDetailsRequest extends StatelessWidget {
  const CustomContainerForDetailsRequest({Key? key, required this.txt})
      : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: MyColors.myGray.withOpacity(0.3),
          border: Border.all(
            color: MyColors.myGray,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        txt,
        style:
            TextStyle(fontSize: 14, color: MyColors.myBlack.withOpacity(0.5)),
      ),
    );
  }
}

class ItemOfCart extends StatefulWidget {
  ItemOfCart({Key? key, this.number = 0, this.date = "", this.eventDate = "", this.createdDate=""})
      : super(key: key);

  dynamic number;
  String? date;
  String? eventDate;
  String? createdDate;

  @override
  State<ItemOfCart> createState() => _ItemOfCartState();
}

class _ItemOfCartState extends State<ItemOfCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.0389),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height*0.18,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  PhotosConstants.eveLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.grayText,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          tr(StringConstants.orderNum),
                          style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.myWhite),
                        ),
                        Expanded(
                          child: Text(
                            widget.number.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: MyColors.myWhite),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.grayText,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          tr(StringConstants.dateCreated),
                          style: const TextStyle(color: MyColors.myWhite,
                          fontSize: 16
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.createdDate ?? "",
                            style: const TextStyle(
                                fontSize: 16, color: MyColors.myWhite),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      widget.eventDate ?? "",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 16, color: MyColors.myWhite),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeleteItemOnCart extends StatelessWidget {
  const DeleteItemOnCart({Key? key, required this.id}) : super(key: key);
final String id ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {
   },
  builder: (context, state) {
    return state is LoadingDelCartState
        ? const Center(
      child:
      CircularProgressIndicator(
        color: MyColors.primaryColor,
      ),
    )
        :MaterialButton(
      shape:
      RoundedRectangleBorder(
          borderRadius:
          BorderRadius
              .circular(
              8)),
      minWidth:
      MediaQuery.of(context)
          .size
          .width *
          0.7,
      onPressed: () {
        BlocProvider.of<
            CartCubit>(
            context)
            .delCartItem(id) ;
      },
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete,
            color: MyColors.myWhite,
          ),
          Text(
            tr(StringConstants
                .deleteTheOrder),
            style: const TextStyle(
                color:
                MyColors.myWhite),
          ),
        ],
      ),
    );
  },
);
  }
}
class DoneOrderDialog extends StatelessWidget {
  const DoneOrderDialog({Key? key, required this.id, required this.message}) : super(key: key);
final String id;
final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.55,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: MyColors.myWhite
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: CircleAvatar(
                        backgroundColor: MyColors.primaryColor,
                        child: IconButton(onPressed: ( ) {
                          Navigator.pop(context);
                        } , icon: Icon(Icons.close)),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                   Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('''${message}''',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 16
                      ),
                    ),
                  )
                  ,
                  const Spacer(
                    flex: 2,
                  ),


                ],
              ),
            ),
            Positioned(
                top: 0,
                child: CircleAvatar(
                  backgroundColor: MyColors.primaryColor,
                  radius: 50,
                  child: SvgPicture.asset(
                    PhotosConstants.eveLogo,
                    width: 30,
                    height: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}