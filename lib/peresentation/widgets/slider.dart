import 'package:cached_network_image/cached_network_image.dart';
import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/home_cubit/home_states.dart';
import '/business_logic/slider/slider_cubit.dart';
import '/business_logic/slider/slider_states.dart';
import '/peresentation/widgets/somooth_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MySlider extends StatelessWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SliderCubit, SliderStates>(
      listener: (context, state) {
        //  state  --> change
      },
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            state is GetSliderLoading || state is GetSliderFailure
                ? const SliderShimmer()
                : CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        BlocProvider.of<SliderCubit>(context)
                            .changeIndexOfSlider(index);
                      },
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      enlargeFactor: 0.3,
                      aspectRatio: 3.0,
                    ),
                    items: BlocProvider.of<HomeCubit>(context).sliders.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              imageUrl: e.image,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const SliderShimmer(),
                              errorWidget: (context, url, error) =>
                                  const SliderShimmer()),
                        ),
                      );
                    }).toList(),
                  ),
            SmoothComponent(
              length: BlocProvider.of<HomeCubit>(context).sliders.length,
            )
          ],
        );
      },
    );
  }
}

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
