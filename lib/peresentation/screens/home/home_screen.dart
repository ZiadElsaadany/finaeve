import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/cart/cart_cubit.dart';
import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/home_cubit/home_states.dart';
import '/business_logic/slider/slider_cubit.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/screens/profile/profile_screen.dart';
import '/peresentation/widgets/album_order_widgets/album_request_row.dart';
import '/peresentation/widgets/circle_lottie_loading.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/peresentation/widgets/party_or_drawing_row.dart';
import '/peresentation/widgets/slider.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../album/album_specifications_page.dart';
import '../../widgets/drawer.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/photo_temlete_in_home.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String id = "home screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    const HomeBody(),
    const AlbumSpecificationScreen(
      home: HomeOrNot.home,
    ),
    ProfileScreen(),
  ];
  var fbm = FirebaseMessaging.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fbm.getToken().then((value) {
      print("=========================================");
      print(value);
      print("=========================================");
    });
    requestPermission();
    showDialogWhenNotificationSend();
  }

  void showDialogWhenNotificationSend() {
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
    return Scaffold(
      appBar: customAppBar(context, home: true),
      drawer: CustomDrawer(),
      body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (c, state) {},
          builder: (context, state) {
            return screens[BlocProvider.of<HomeCubit>(context).currentIndex];
          }),
      bottomNavigationBar: BlocConsumer<HomeCubit, HomeStates>(
        listener: (ctx, state) {},
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: MyColors.primaryColor,
            currentIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
            onTap: (index) {
              debugPrint(index.toString());
              if ((index == 2 || index == 1) && token == null) {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return LoginPage();
                }));
              } else {
                if (index == 1) {
                  BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .changeIndexOfSelectedRequestOfAlbum(
                          indexOfSelectedRequestOfAlbum: 0);
                }
                BlocProvider.of<HomeCubit>(context)
                    .changeCurrentIndexForBottomNavBar(index: index);
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_filled),
                  label: tr(StringConstants.main)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      BlocProvider.of<HomeCubit>(context).currentIndex == 1
                          ? PhotosConstants.navAlbumSelected
                          : PhotosConstants.navAlbumUnSelected),
                  label: tr(StringConstants.albumOrder)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: tr(StringConstants.profile2)),
            ],
          );
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return const CustomHome();
          // widget with initState   -->   apis
        } else {
          return child;
        }
      },
      child: NoInternetWidget(
        txt: tr(StringConstants.noInternet),
      ),
    );
  }
}

class CustomHome extends StatefulWidget {
  const CustomHome({Key? key}) : super(key: key);

  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {

  @override
  void initState() {

    super.initState();
    Future.delayed(Duration.zero, () async {
      BlocProvider.of<HomeCubit>(context).getSliders();
      BlocProvider.of<SliderCubit>(context).sliderBottomHome();
      BlocProvider.of<CartCubit>(context).getCart();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (ctx, state) {
        if (state is GetSliderFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return state is GetSliderLoading?
            ? const CircleLoadingByLottie()
            : ListView(physics: const BouncingScrollPhysics(), children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const MySlider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      AlbumRequestRow(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      const PartyOrDrawingRequestRow(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      const PhotoTemplate(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]);
      },
    );
  }
}
