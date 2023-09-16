import 'package:easy_localization/easy_localization.dart';
import '/business_logic/conatct_us_cubit/conact_us_states.dart';
import '/business_logic/conatct_us_cubit/conatct_us_cubit.dart';
import '/peresentation/screens/contact_us/rectangle_template.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../../main.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';
import 'input_form_feild.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15,
          ),
          child: OfflineBuilder(
            connectivityBuilder: (BuildContext ctx,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return const CustomContactUsScreen();
                // widget with initState   -->   apis
              } else {
                return child;
              }
            },
            child: NoInternetWidget(
              txt: tr(StringConstants.noInternet),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContactUsScreen extends StatefulWidget {
  const CustomContactUsScreen({Key? key}) : super(key: key);

  @override
  State<CustomContactUsScreen> createState() => _CustomContactUsScreenState();
}

class _CustomContactUsScreenState extends State<CustomContactUsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactUsCubit>(context).getContactInformation();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String contactUs = "contactUs";
    return BlocConsumer<ContactUsCubit, ContactStates>(
      listener: (context, state) {
        if (state is FailureContactUsState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.message)));
        } else if (state is FailurePostContactUsState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.message)));
        } else if (state is SuccessPostContactUsState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green, content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return state is LoadingContactUsState || state is FailureContactUsState
            ? const Center(child: CircleLoadingByLottie())
            : Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      tr(StringConstants.contactUs),
                      style: const TextStyle(
                          color: MyColors.primaryColor, fontSize: 20),
                    ),
                    Image.asset(
                      ImageConstants.rectangleDesign,
                      width: 23,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.myWhite),
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.013,
                          horizontal:
                              MediaQuery.of(context).size.width * 0.012),
                      child: Column(
                        children: [
                          InputFormFieldWithoutHeader(
                            hintText: tr(StringConstants.theName),
                            controller: nameController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          InputFormFieldWithoutHeader(
                            hintText: tr(StringConstants.mobile),
                            type: TextInputType.phone,
                            controller: mobileController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          InputFormFieldWithoutHeader(
                            hintText: tr(StringConstants.email),
                            controller: emailController,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          InputFormFieldWithoutHeader(
                            controller: messageController,
                            hintText: tr(StringConstants.theMessage),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    state is LoadingPostContactUsState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                            ),
                          )
                        : ElevatedButtonTemplate(
                            buttonText: tr(StringConstants.send),
                            buttonColor: MyColors.primaryColor,
                            onPressed: () {

                                BlocProvider.of<ContactUsCubit>(context)
                                    .postContact(
                                        name: nameController.text,
                                        mobile: mobileController.text,
                                        email: emailController.text,
                                        message: messageController.text);

                            }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    RectangleTemplate(
                        image: PhotosConstants.navigation,
                        txt: BlocProvider.of<ContactUsCubit>(context)
                                .contactModel
                                ?.address ??
                            ""),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        openPhoneDialer(
                            BlocProvider.of<ContactUsCubit>(context)
                                    .contactModel
                                    ?.mobile ??
                                "",
                            context);
                      },
                      child: RectangleTemplate(
                          image: PhotosConstants.mobileNotch,
                          txt: BlocProvider.of<ContactUsCubit>(context)
                                  .contactModel
                                  ?.mobile ??
                              ""),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        openGmailApp(
                            BlocProvider.of<ContactUsCubit>(context)
                                    .contactModel
                                    ?.email ??
                                "",
                            context);
                      },
                      child: RectangleTemplate(
                          image: PhotosConstants.message,
                          txt: BlocProvider.of<ContactUsCubit>(context)
                                  .contactModel
                                  ?.email ??
                              ""),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ],
                ),
              );
      },
    );
  }
}
