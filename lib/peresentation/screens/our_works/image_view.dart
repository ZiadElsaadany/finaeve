import 'package:cached_network_image/cached_network_image.dart';
import '/utilities/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../models/woks_model.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.image1, required this.imgs}) : super(key: key);
  final Images image1 ;
final List<Images> imgs;
  static const String id= "ImageViewId";
  @override
  Widget build(BuildContext context) {
    List<Images> images= [
      image1
    ];
        images.addAll(
            imgs
        );
        List<Images> setImages= images.toSet().toList();
    return Scaffold(
      backgroundColor:Color(0xff707070),
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: GestureDetector(
              onTap: ( ) {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor:MyColors.myWhite ,
                child: Icon(Icons.close,
                color: MyColors.primaryColor,
                ),
              ),
            ),
          )
        ],
        backgroundColor: Color(0xff707070),
        elevation: 0,
      ),
      body: PageView.builder(
        // padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
          itemCount: setImages.length,
          itemBuilder: (ctx,index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InteractiveViewer(
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl:setImages[index].image ,

            ),
          ),
        );
      }),
    );
  }
}
