import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/peresentation/models/woks_model.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/screens/our_works/image_view.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utilities/constants/colors.dart';
import '../../widgets/shared_widgets/go_to_album.dart';

class MyServices extends StatelessWidget {
  const MyServices({Key? key, required this.model}) : super(key: key);

  final WorksModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: ListView(

        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: model.image,
                placeholder: (c, x) {
                  return const SizedBox();
                },
                errorWidget: (c, x, s) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.locale == const Locale("en")
                      ? parseHtmlString(model.titleEn)
                      : parseHtmlString(
                    model.title,
                  ),
                  style: const TextStyle(
                      fontSize: 22, color: MyColors.primaryColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  context.locale == const Locale("en")
                      ? parseHtmlString(model.textEn)
                      : parseHtmlString(
                    model.text,
                  ),
                  style: const TextStyle(
                      fontSize: 16, color: MyColors.myBlack),
                ),

              ],
            ),
          ),
          GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: 15
              ),
            shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
              itemCount: model.images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5
              ), itemBuilder: (ctx,index) {
            return GestureDetector(
              onTap:  ( )  {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return ImageView(
                  image1:model.images[index] ,
                  imgs: model.images,
                  );
                }));
              },
              child: CachedNetworkImage(
                height:
                MediaQuery.of(context).size.height * 0.15,
                imageUrl: model.images[index].image,
                fit: BoxFit.cover,
                placeholder: (C, x) {
                  return const SizedBox();
                },
                errorWidget: (x, n, m) {
                  return const Icon(Icons.error);
                },
              ),
            );
          })

          // ListView.builder(
          //
          //   shrinkWrap: true,
          //   itemCount: model.images.length,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (ctx,index ) {
          //       return
          //     } ),

          ,
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const RequestAlbumImage(),
          ),
           SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
        ],
      ),
    );
  }
}
