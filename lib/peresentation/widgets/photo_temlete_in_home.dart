import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/business_logic/slider/slider_cubit.dart';
import '/business_logic/slider/slider_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PhotoTemplate extends StatelessWidget {
  const PhotoTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SliderCubit, SliderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
          // width: MediaQuery.of(context).size.width*0.9,
          child: CarouselSlider(
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: 260,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: false,
              viewportFraction: 0.5,
              enlargeFactor: 2,
            ),
            items: state is BottomSliderStateLoading
                ? [const SliderBottomShimmer()]
                : BlocProvider.of<SliderCubit>(context)
                    .bottomSlider
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * 0.5,
                            fit: BoxFit.cover,
                            imageUrl: e.image,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const SliderBottomShimmer(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}

class SliderBottomShimmer extends StatelessWidget {
  const SliderBottomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
      ),
    );
  }
}

//
//
//
// ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemCount:
//             BlocProvider.of<SliderCubit>(context)
//                 .bottomSlider.length,
//             itemBuilder: (context, index) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: CachedNetworkImage(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   width: MediaQuery.of(context).size.height * 0.266,
//                   fit: BoxFit.cover,
//                   imageUrl: BlocProvider.of<SliderCubit>(context)
//                       .bottomSlider[index]
//                       .image,
//                   placeholder: (c, x) {
//                     return const SizedBox();
//                   },
//                   errorWidget: (c, s, e) {
//                     return const Icon(Icons.error);
//                   },
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.05,
//               );
//             },
//           )
