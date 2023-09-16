import 'package:easy_localization/easy_localization.dart';
import '/business_logic/query_cubit/query_cubit.dart';
import '/business_logic/query_cubit/query_states.dart';
import '/peresentation/widgets/shared_widgets/header_text.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utilities/constants/colors.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/elevated_button.dart';
import '../../widgets/shared_widgets/header_image.dart';
import 'order_query_details.dart';

class OrderQueryScreen extends StatelessWidget {
  OrderQueryScreen({Key? key}) : super(key: key);
  static const String id = 'orderQueryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return CustomOrderQuery();
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

class CustomOrderQuery extends StatelessWidget {
  CustomOrderQuery({Key? key}) : super(key: key);
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Form(
                  key: _form,
                  child: BlocConsumer<QueryCubit, QueryStates>(
                    listener: (context, state) {
                      if (state is FailureQueryState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.message)));
                      } else if (state is SuccessQueryState) {
                        Navigator.of(context).push(PageTransition(
                          child: OrderQueryDetailsScreen(
                            number: BlocProvider.of<QueryCubit>(context)
                                .queryModel!
                                .id,
                            status: BlocProvider.of<QueryCubit>(context)
                                .queryModel!
                                .status,
                            date: BlocProvider.of<QueryCubit>(context)
                                .queryModel!
                                .createdAt,
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 500),
                        ));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeaderText(text: tr(StringConstants.orderQuery)),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.myWhite,
                            ),
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.02,
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.height * 0.035),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller,
                              validator: (mm) {
                                if (mm == null || mm.isEmpty) {
                                  return "Number of order is required";
                                } else {
                                  return null;
                                }
                              },
                              cursorColor: MyColors.primaryColor,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: MyColors.colorWhite,
                                prefixIcon: Image.asset(
                                  "assets/images/request_follwoing_icon.png",
                                  color: MyColors.deepGray,
                                ),
                                hintText: tr(StringConstants.orderNum),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(color: MyColors.deepGray)),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide:
                                      BorderSide(color: MyColors.deepGray),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3),
                          state is LoadingQueryState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: MyColors.primaryColor,
                                ))
                              : ElevatedButtonTemplate(
                                  buttonText: tr(StringConstants.send),
                                  buttonColor: MyColors.primaryColor,
                                  onPressed: () {
                                    if (_form.currentState!.validate()) {
                                      BlocProvider.of<QueryCubit>(context)
                                          .postQuery(id: controller.text);
                                    }
                                  }),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
