import 'package:cached_network_image/cached_network_image.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/peresentation/models/list_models.dart';
import '/peresentation/widgets/album_order_widgets/album_specification_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../../utilities/constants/colors.dart';
class AlbumOrderGridView extends StatelessWidget {
  const AlbumOrderGridView({Key? key, required this.images}) : super(key: key);
final List<ModelImage>  images ;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: GridView.builder(
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

              BlocProvider.of<ListsCubit>(context).changeModelImages(
                BlocProvider.of<ListsCubit>(context).dataAllMenues!.modelImages![index].id
              );

              BlocProvider.of<ListsCubit>(context).funGetPrice(context);

            },
            child: Container (
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color:

                  BlocProvider.of<ListsCubit>(context).dataAllMenues!.modelImages![index].id  ==
                      BlocProvider.of<ListsCubit>(context).modelImage?.id
                      ?MyColors.myBlack:Colors.transparent
                      ,
                      width: 2
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  )),
              // padding: EdgeInsets.symmetric(
              //     vertical: MediaQuery.of(context).size.height * 0.01,
              //     horizontal: MediaQuery.of(context).size.width * 0.005),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                images[index].imageUrl,
                placeholder: (c,d)  {
                  return const SizedBox();
                },
                errorWidget: (c,x,d) {
                  return  const Icon(Icons.error);
                },
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     // ClipRRect(
              //     //   borderRadius: BorderRadius.circular(8),
              //     //   child: Image.asset(
              //     //     '',
              //     //     width: MediaQuery.of(context).size.width * 0.2,
              //     //   ),
              //     // ),
              //     // const FittedBox(
              //     //   child: Column(
              //     //     children: [
              //     //       Text(
              //     //         StringConstants.albumName,
              //     //         style: TextStyle(
              //     //           color: MyColors.myGray,
              //     //           fontSize: 12,
              //     //         ),
              //     //       ),
              //     //       Text(
              //     //         'Model A32151',
              //     //         style: TextStyle(
              //     //           color: MyColors.primaryColor,
              //     //           fontSize: 10,
              //     //         ),
              //     //       )
              //     //     ],
              //     //   ),
              //     // )
              //   ],
              // ),
            ),
          );
        },
        itemCount:images.length,
      ),
    );
  }
}
