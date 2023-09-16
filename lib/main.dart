import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evephotography/utilities/constants/colors.dart';
import '/business_logic/Lists/lists_cubit.dart';
import '/business_logic/all_requests_cubit/all_request_cubit.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/bouquet_order/bouquet_order_cubit.dart';
import '/business_logic/bouquets/bouquets_cubit.dart';
import '/business_logic/change_points/change_points_cubit.dart';
import '/business_logic/conatct_us_cubit/conatct_us_cubit.dart';
import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/my_plan_order/my_plan_order_cubit.dart';
import '/business_logic/our_advantages/our_advantages_cubit.dart';
import '/business_logic/our_services/our_services_cubit.dart';
import '/business_logic/query_cubit/query_cubit.dart';
import '/business_logic/questions_cubit/questions_cubit.dart';
import '/business_logic/register_cubit/register_cubit.dart';
import '/business_logic/slider/slider_cubit.dart';
import '/business_logic/works_cubit/works_cubit.dart';
import '/peresentation/album/print_album/album_materials_screen.dart';
import '/peresentation/album/album_specifications_page.dart';
import '/peresentation/album/print_album/end_order_screen.dart';
import '/peresentation/screens/bouquet/bouquet_list_view.dart';
import '/peresentation/screens/home/home_screen.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/screens/auth/forget_pass_page.dart';
import '/peresentation/screens/auth/register_page.dart';
import '/peresentation/screens/language/language_screen.dart';
import '/peresentation/screens/order_query/order_query_screen.dart';
import '/peresentation/screens/our_advantages/our_advantages_screen.dart';
import '/peresentation/screens/our_services/our_servies_screen.dart';
import '/peresentation/screens/profile/information_profile_screen.dart';
import '/peresentation/screens/profile/password_screen.dart';
import '/peresentation/screens/splash/splash_screen.dart';
import '/peresentation/widgets/no_login_widget.dart';
import '/utilities/constants/string_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'business_logic/album_order/album_details_row_cubit.dart';
import 'business_logic/cart/cart_cubit.dart';
import 'business_logic/change_password/chnage_password_cubit.dart';
import 'business_logic/get_image_comments/get_image_comments_cubit.dart';
import 'business_logic/image-comments/image_comments_cubit.dart';
import 'business_logic/password_reset/reset_password_cubit.dart';
import 'business_logic/points/points_cubit.dart';
import 'firebase_options.dart';

void main() async {
  print("start app");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  await EasyLocalization.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  token = sharedPref.getString("token");
  userNamee = sharedPref.getString("userName");

  name = sharedPref.getString("name");
  avatar = sharedPref.getString("avatar");
  userId = sharedPref.getInt("userId");
  email = sharedPref.getString("email");
  mobile = sharedPref.getString("mobile");
  loc = sharedPref.getString("loc")??"ar";
debugPrint("language is  :  $loc") ;
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => SliderCubit()),
        BlocProvider(create: (ctx) => HomeCubit()),
        BlocProvider(create: (ctx) => GetImageCommentsCubit()),
        BlocProvider(create: (ctx) => BouquetOrderCubit()),
        BlocProvider(create: (ctx) => AlbumDetailsRowCubit()),
        BlocProvider(create: (ctx) => AuthCubit()),
        BlocProvider(create: (ctx) => AllRequestCubit()),
        BlocProvider(create: (ctx) => QuestionsCubit()),
        BlocProvider(create: (ctx) => WorksCubit()),
        BlocProvider(create: (ctx) => RegisterCubit()),
        BlocProvider(create: (ctx) => ContactUsCubit()),
        BlocProvider(create: (ctx) => QueryCubit()),
        BlocProvider(create: (ctx) => BouquetsCubit()),
        BlocProvider(create: (ctx) => MyPlanOrderCubit()),
        BlocProvider(create: (ctx) => ListsCubit()),
        BlocProvider(create: (ctx) => ResetPasswordCubit()),
        BlocProvider(create: (ctx) => ImageCommentsCubit()),
        BlocProvider(create: (ctx) => OurServicesCubit()),
        BlocProvider(create: (ctx) => PointsCubit()),
        BlocProvider(create: (ctx) => ChangePointsCubit()),
        BlocProvider(create: (ctx) => ChnagePasswordCubit()),
        BlocProvider(create: (ctx) => CartCubit()),
        BlocProvider(create: (ctx) => OurAdvantagesCubit()),
      ],
      child: EasyLocalization(
          supportedLocales: const [
            Locale('en'), // English (United States)
            Locale('ar'), // Arabic
          ],
          path: 'assets/translations',
          // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          saveLocale: true,
          startLocale: const Locale('ar'),
          child: MyApp())));
}

class MyApp extends StatelessWidget {
  final String dinNextBold = 'DinNextBold.woff2';
  final String dinNextLight = 'DinNextLight.woff2';
  void showDialogWhenNotificationSend(context) {
    FirebaseMessaging.onMessage.listen((event) {
      showDialog(
          context: context,
          builder: (cxt) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/eve_logo.png'),
                    radius: 20,
                  ),
                  Text(
                    "Eve",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.all(10),
              content: Text("${event.notification!.body}",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: MyColors.primaryColor),
                    ))
              ],
            );
          });
    });
  }
  var fbm = FirebaseMessaging.instance;

  void requestPermission() async {
    NotificationSettings settings = await fbm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      theme: ThemeData(
          listTileTheme: const ListTileThemeData(
            dense: true,
            // selectedColor: MyColors.primaryColor
          ),
          fontFamily: "DinNextRegular",
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            fontFamily: "DinNextRegular",
          ))),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        ForgetPassPage.id: (context) => const ForgetPassPage(),
        HomeScreen.id: (ctx) => HomeScreen(),
        AlbumSpecificationScreen.id: (context) =>
            const AlbumSpecificationScreen(),
        AlbumMaterialScreen.id: (context) => const AlbumMaterialScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        EndOrderScreen.id: (context) => const EndOrderScreen(),
        NoLoginWidget.id: (context) => const NoLoginWidget(),
        InformationProfileScreen.id: (ctx) => InformationProfileScreen(),
        PasswordScreen.id: (ctx) => PasswordScreen(),
        BouquetFirstScreen.id: (context) => const BouquetFirstScreen(),
        OrderQueryScreen.id: (context) => OrderQueryScreen(),
        LanguageScreen.id: (context) => const LanguageScreen(),
        OurServicesScreen.id: (context) => const OurServicesScreen(),
        OurAdvantagesScreen.id: (context) => const OurAdvantagesScreen(),
      },
    );
  }
}

Future<String> getDeviceType() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return 'android';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return 'ios';
  } else {
    return 'Unknown';
  }
}

void openPhoneDialer(String phoneNumber, context) async {
  final url = 'tel:$phoneNumber';
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(StringConstants.problemMessageInCubit))));
  }
}

void openGmailApp(String emailAddress, context) async {
  final url = 'mailto:$emailAddress';
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  } catch (E) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(StringConstants.problemMessageInCubit))));
  }
}
