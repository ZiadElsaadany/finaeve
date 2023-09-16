import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/bouquet_order/bouquet_order_cubit.dart';
import '/peresentation/screens/bouquet/reserved_bouquets_screen.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../models/bouquets_model.dart';
import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';

class RequestBouquet extends StatefulWidget {
  const RequestBouquet({Key? key, required this.model}) : super(key: key);
  static const String id = 'request bouquet';

  final BouquetsModel model;

  @override
  State<RequestBouquet> createState() => _RequestBouquetState();
}

class _RequestBouquetState extends State<RequestBouquet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              const HeaderImage(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: MyColors.myWhite,
                    )),
              )
            ],
          ),
          Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: HeaderText(
                        text: tr(StringConstants.bouquetOrder),
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.28,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.model.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Expanded(
                      //   child: Container(
                      //     color: MyColors.myYellow,
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: MediaQuery.of(context)
                      //                 .size
                      //                 .height *
                      //             0.01,
                      //         horizontal: MediaQuery.of(context)
                      //                 .size
                      //                 .width *
                      //             0.09),
                      //     child:  Text(
                      //       '${widget.model.price} SAR',
                      //       textAlign: TextAlign.center,
                      //       style:
                      //           const TextStyle(color: MyColors.myWhite),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.myWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.005,
                        horizontal: MediaQuery.of(context).size.width * 0.0389),
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.0389),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.locale == const Locale("en")
                              ? parseHtmlString(widget.model.nameEn)
                              : parseHtmlString(widget.model.name),
                          style: const TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Text(
                            context.locale == const Locale("en")
                                ? parseHtmlString(widget.model.description)
                                : parseHtmlString(widget.model.descriptionEn),
                            style: const TextStyle(
                                fontSize: 16, color: MyColors.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width*0.15
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.myYellow,

                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.25,
                          vertical: MediaQuery.of(context).size.height*0.008
                      ),
                      child: Text( "${widget.model.price.toString()}   ${tr(StringConstants.SAR)}",
                        style: TextStyle(
                            color: MyColors.myWhite,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null && pickedDate != selectedDate) {
                          selectedDate = pickedDate;

                          setState(() {});
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(StringConstants.dateOfCelebration),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.myBlack,
                                ),
                                borderRadius: BorderRadius.circular(9)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(PhotosConstants.calenderG),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    selectedDate.toString() == "null"
                                        ? tr(
                                            StringConstants.history,
                                          )
                                        : selectedDate
                                            .toString()
                                            .split(" ")
                                            .first,
                                    style: TextStyle(fontSize: 16)),
                                const Spacer(),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/blue_container.png"),
                                    SvgPicture.asset(PhotosConstants.calenderW)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null && pickedTime != selectedTime) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(StringConstants.timeOfCelebration),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.myBlack,
                                ),
                                borderRadius: BorderRadius.circular(9)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(PhotosConstants.clockG),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    selectedTime.toString() == "null"
                                        ? tr(StringConstants.time)
                                        : selectedTime!.hour.toString() +
                                            ":" +
                                            selectedTime!.minute.toString(),
                                    style: TextStyle(fontSize: 16)),
                                const Spacer(),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/blue_container.png"),
                                    Image.asset(
                                      ImageConstants.timeAddIcon,
                                      color: MyColors.myWhite,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: BlocConsumer<BouquetOrderCubit, BouquetOrderState>(
                      listener: (context, state) {
                        if (state is SuccessPostBouquetOrderState) {
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     backgroundColor: Colors.green,
                          //     content: Text(state.message)));




                          showDialog(context: context, builder: (ctx) {
                            return SizedBox(
                                height: 200,
                                child:  RequestBouquetDialog(
                                  message: state.message,
                                ));
                          });

                        } else if (state is FailurePostBouquetOrderState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        return state is LoadingPostBouquetOrderState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                ),
                              )
                            : MaterialButton(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  BlocProvider.of<BouquetOrderCubit>(context)
                                      .postBouquetOrder(
                                          id: widget.model.id,
                                          price: "${widget.model.price}",
                                          date: selectedDate
                                                  ?.toString()
                                                  .split(" ")
                                                  .first ??
                                              "",
                                          time: selectedTime != null
                                              ? "${selectedTime?.hour.toString() ?? ""}:${selectedTime?.minute.toString() ?? ""}"
                                              : "");
                                },
                                color: MyColors.primaryColor,
                                textColor: MyColors.myWhite,
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(tr(StringConstants.bouquetOrder),
                                      style: TextStyle(fontSize: 16)),
                                ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
class RequestBouquetDialog extends StatelessWidget {
  const RequestBouquetDialog({Key? key,  required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.4,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: GestureDetector(
                      onTap: ( ) {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (  ctx){
                            return ReservedBouquets();
                          }
                        ));
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset("assets/images/border.png",
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( tr(StringConstants.reversedBouquets),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,

                                      color: MyColors.primaryColor
                                  ),

                                )


                              ],
                            ),
                          ) ,


                        ],
                      ),
                    ),
                  ),
                  const Spacer( ),


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