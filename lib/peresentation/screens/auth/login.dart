import 'package:easy_localization/easy_localization.dart';
import 'package:evephotography/peresentation/screens/language/language_screen.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/auth_cubit/auth_states.dart';
import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/home_cubit/home_states.dart';
import '/peresentation/screens/auth/forget_pass_page.dart';
import '/peresentation/screens/auth/register_page.dart';
import '/peresentation/screens/home/home_screen.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/peresentation/widgets/shared_widgets/header_image.dart';
import '/peresentation/widgets/shared_widgets/header_text.dart';
import '/peresentation/widgets/shared_widgets/text_form_field.dart';
import '/utilities/constants/images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import 'activate_the_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.index = 0, this.logoutOrNot = false,this.loginAgainOrNot=false})
      : super(key: key);
  static const String id = 'login page';
  final int index;
  final bool logoutOrNot;
  final bool loginAgainOrNot;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  var fbm = FirebaseMessaging.instance;
  @override
  void initState() {
    fbm.getToken().then((value) {
      notificationToken = value;
      // requestPermission();
      debugPrint("=========================================");
      debugPrint(notificationToken.toString());
      debugPrint("=========================================");
    });
    super.initState();
  }

  // void requestPermission() async {
  //   NotificationSettings settings = await fbm.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     debugPrint('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     debugPrint('User granted provisional permission');
  //   } else {
  //     debugPrint('User declined or has not accepted permission');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                backgroundColor: Colors.green,
                content: Text(state.loginSuccess)));
            Navigator.of(context).pushReplacementNamed(HomeScreen.id);
            debugPrint( "notificationToken: ${notificationToken.toString()}");
            debugPrint( "getDeviceType: ${await getDeviceType()}");
            BlocProvider.of<AuthCubit>(context).deviceToken(
                deviceToken: notificationToken.toString(),
                device_type: await getDeviceType());
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                backgroundColor: Colors.red,
                content: Text(state.loginFailureMessage)));
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is LoginLoading,
            child: Column(
              children: [
                widget.index == 0
                    ? widget.logoutOrNot == true
                        ? HeaderImage()
                        : Stack(
                            children: [
                              const HeaderImage(),
                    widget.loginAgainOrNot ?
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 30),
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).removeShared();
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)  {
                             return HomeScreen();
                           } ));
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.myWhite,
                          )),
                    )
                        :          Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 30),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: MyColors.myWhite,
                                    )),
                              )
                            ],
                          )
                    : SizedBox(),
                Expanded(
                  flex: 3,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    children: [
                      HeaderText(
                        text: tr(StringConstants.login),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              TextFormFieldTemplate(
                                prefixIcon: const Icon(Icons.phone),
                                hintText:
                                    tr(StringConstants.phoneNumRegistration),
                                validator: (value) => value!.isEmpty
                                    ? tr(StringConstants.pleaseEnterPhoneNum)
                                    : null,
                                controller: _phoneController,
                                type: TextInputType.text,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              BlocConsumer<HomeCubit, HomeStates>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  return TextFormFieldTemplate(
                                    // true
                                    // false

                                    obscureText:
                                        BlocProvider.of<HomeCubit>(context).eye,

                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: tr(StringConstants.pass),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterThePass)
                                        : null,
                                    controller: _passController,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<HomeCubit>(context)
                                            .changeEye();
                                      },
                                      icon: Icon(
                                          BlocProvider.of<HomeCubit>(context)
                                                  .eye
                                              ? Icons.visibility_off
                                              : Icons.remove_red_eye_outlined),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  child: Text(
                                    tr(StringConstants.lostPassword),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: MyColors.primaryColor,
                                          fontSize: 20,
                                        ),
                                  ),
                                  onTap: () {
                                    _phoneController.clear();
                                    _passController.clear();
                                    Navigator.of(context)
                                        .pushNamed(ForgetPassPage.id);
                                  },
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                              ),
                              state is LoginLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: MyColors.primaryColor,
                                    ))
                                  : ElevatedButtonTemplate(
                                      buttonColor: MyColors.primaryColor,
                                      buttonText: tr(StringConstants.login),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .login(
                                                  userName:
                                                      _phoneController.text,
                                                  password:
                                                      _passController.text)
                                              .then((value) {
                                            Future.delayed(Duration.zero,
                                                () async {
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .deviceToken(
                                                      deviceToken: fbm
                                                          .getToken()
                                                          .toString(),
                                                      device_type:
                                                          await getDeviceType())
                                                  .then((value) {
                                                debugPrint(
                                                    "${fbm.getToken()} , , , ,  ,${getDeviceType()}");
                                              });
                                            });
                                          });
                                        }
                                      },
                                    ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              ElevatedButtonTemplate(
                                buttonColor: MyColors.myYellow,
                                buttonText: tr(StringConstants.register),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterPage.id);
                                },
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return ActivateTheAccountScreen(
                                      phone:"",
                                    );
                                  }));
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.asset(ImageConstants.pointsBorder),
                                    Text(
                                        tr(StringConstants
                                            .uCanConfirmYourAccountFromHere),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              color: MyColors.primaryColor,
                                              fontSize: 16,
                                            ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
