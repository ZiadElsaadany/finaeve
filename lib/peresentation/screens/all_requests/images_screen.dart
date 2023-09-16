import 'package:cached_network_image/cached_network_image.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/show_request_model.dart';
import 'notes_image.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key, required this.images}) : super(key: key);
  final List<AlbumImage> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (ctx, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                            child: NotesScreenImage(
                              imgUrl: images[index].image,
                              imgId: '${images[index].id}',
                            ),
                            type: PageTransitionType.bottomToTop,
                            duration: const Duration(seconds: 1),
                            reverseDuration: const Duration(milliseconds: 500),
                          ));
                        },
                        child: CachedNetworkImage(
                          imageUrl: images[index].image,
                          placeholder: (c, s) {
                            return ImagesShimmer(images: images);
                          },
                          errorWidget: (c, v, b) {
                            return const Icon(Icons.error);
                          },
                        )),
                  ));
            }));
  }
}

class ImagesShimmer extends StatelessWidget {
  const ImagesShimmer({Key? key, required this.images}) : super(key: key);
  final List<AlbumImage> images;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: images.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (ctx, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CachedNetworkImage(
                imageUrl: images[index].image,
                placeholder: (context, url) {
                  return Container(
                    color: Colors.white,
                  );
                },
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
