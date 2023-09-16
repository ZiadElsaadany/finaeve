import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/image-comments/image_comments_cubit.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../business_logic/get_image_comments/get_image_comments_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';

class NotesScreenImage extends StatefulWidget {
  final String imgUrl;
  final String imgId;
  const NotesScreenImage({Key? key, required this.imgUrl, required this.imgId})
      : super(key: key);
  @override
  State<NotesScreenImage> createState() => _NotesScreenImageState();
}

class _NotesScreenImageState extends State<NotesScreenImage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<GetImageCommentsCubit>(context)
          .getComments(imageId: widget.imgId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: MyColors.primaryColor,
      //   title: Image.asset(
      //     '',
      //     fit: BoxFit.cover,
      //     width: MediaQuery.of(context).size.width * 0.2,
      //     height: MediaQuery.of(context).size.height * 0.09,
      //   ),
      //   actions: [Image.asset('')],
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: true,
            snap: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.imgUrl, // Replace with your image URL
                fit: BoxFit.contain,
              ),
            ),
          ),

          BlocConsumer<GetImageCommentsCubit, GetImageCommentsState>(
            listener: (context, state) {
              if (state is GetImageCommentsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              return state is GetImageCommentsLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircleLoadingByLottie(),
                      ),
                    )
                  : BlocProvider.of<GetImageCommentsCubit>(context)
                          .imageCommentsData
                          .isEmpty
                      ?  SliverToBoxAdapter(
                          child: Center(
                            child: Text(tr(StringConstants.noComments)),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return BlocProvider.of<GetImageCommentsCubit>(
                                  context)
                                  .imageCommentsData[index].userType == 2?
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            BlocProvider.of<GetImageCommentsCubit>(
                                                context)
                                                .imageCommentsData[index].commentText     ,
                                            style: TextStyle(
                                                color: MyColors.myBlack.withOpacity(0.5),
                                                fontSize: 16
                                            ),
                                          )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: MyColors.primaryColor,
                                        radius: 35,
                                        child: SvgPicture.asset(
                                          PhotosConstants.eveLogo,
                                          fit: BoxFit.contain,
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height*0.08,
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                                  :
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/yellow_circle.png",
                                    height: MediaQuery.of(context).size.height*0.13,
                                  ),


                                  Expanded(
                                      child: Text(
                                    BlocProvider.of<GetImageCommentsCubit>(
                                            context)
                                        .imageCommentsData[index]
                                        .commentText,
                                    style: TextStyle(
                                        fontSize: 16
,
                                        color: MyColors.myBlack
                                            .withOpacity(0.5)),
                                  )),
                                ],
                              );
                            },
                            childCount: BlocProvider.of<GetImageCommentsCubit>(
                                    context)
                                .imageCommentsData
                                .length, // Replace with your actual item count
                          ),
                        );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 20),
              child: Column(
                children: [
                   Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        tr(StringConstants.theNotes),
                        textAlign: TextAlign.start,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    minLines: 4,
                    maxLines: 10,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText:                         tr(StringConstants.notes),
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(),
                        border: outlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<ImageCommentsCubit, ImageCommentsState>(
                    listener: (context, state) {
                      if (state is PostImageCommentsFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ));
                      } else if (state is PostImageCommentsLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ));
                        BlocProvider.of<GetImageCommentsCubit>(context)
                            .getComments(imageId: widget.imgId);
                      }
                    },
                    builder: (context, state) {
                      return state is PostImageCommentsLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: MyColors.primaryColor,
                              ),
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPressed: () {
                                BlocProvider.of<ImageCommentsCubit>(context)
                                    .postComment(
                                        imageId: widget.imgId,
                                        comment: controller.text);
                              },
                              color: MyColors.primaryColor,
                              minWidth: double.infinity,
                              child: const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Text(
                                  "ارسال",
                                  style: TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: MyColors.myGray));
}
