import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/home_cubit/home_cubit.dart';
import '/business_logic/home_cubit/home_states.dart';
import '/peresentation/album/album_specifications_page.dart';
import '/peresentation/screens/all_requests/all_requests_screen.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/screens/auth/register_page.dart';
import '/peresentation/screens/bouquet/bouquet_list_view.dart';
import '/peresentation/screens/cart_screen/cart_screen.dart';
import '/peresentation/screens/contact_us/contact_us_screen.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/screens/language/language_screen.dart';
import '/peresentation/screens/order_query/order_query_screen.dart';
import '/peresentation/screens/our_advantages/our_advantages_screen.dart';
import '/peresentation/screens/our_services/our_servies_screen.dart';
import '/peresentation/screens/our_works/our_works_screen.dart';
import '/peresentation/screens/points/points_screen.dart';
import '/peresentation/screens/what_say_about/what_say_about_screen.dart';
import '/peresentation/screens/who/eve_screen.dart';
import '/peresentation/widgets/shared_widgets/header_image.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../business_logic/album_order/album_details_row_cubit.dart';
import '../screens/bouquet/reserved_bouquets_screen.dart';
import 'package:http/http.dart' as http;
class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const HeaderImage()),
          token == null
              ? Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const LoginPage();
                        }));
                      },
                      child: IconAndTitleListTile(
                          textColor: MyColors.myGray,
                          iconImage: PhotosConstants.loginIconDrawer,
                          title: tr(StringConstants.login)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const RegisterPage();
                        }));
                      },
                      child: IconAndTitleListTile(
                          textColor: MyColors.myGray,
                          iconImage: PhotosConstants.registerIconDrawer,
                          title: tr(StringConstants.register)),
                    ),
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
                  child: MaterialButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context).changeCurrentIndexForBottomNavBar(index: 2);
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: MyColors.primaryColor,
                    minWidth: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 12),
                      child: Row(
                        children: [
                          SvgPicture.asset(PhotosConstants.loginIconDrawer,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Text(
                            userNamee ?? "",
                            style: const TextStyle(color: MyColors.myWhite),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                ListOfIconAndTitle(),
                token !=null?

         GestureDetector(
           onTap:  (    )  async {
             try {
               http.Response res = await
                   http.post(Uri.parse("https://www.eve-albums.com/api/web/v1/site/delete-account?access-token=$token"),
                   headers:  {
                     "Accept-Language":"$loc"
                   }
                   );
               if(res.statusCode == 200) {
                 if(jsonDecode(res.body)["status"] == 1 ) {
                   ScaffoldMessenger.of(context).showSnackBar(

                       SnackBar(
                       backgroundColor: Colors.green
                       ,content: Text(
                         jsonDecode(res.body)["data"][0]["message"]

                   )));
                   SharedPreferences prefs  = await SharedPreferences.getInstance();
                   prefs.remove("token");
                   restartLogin (context);
                 }else {

                   ScaffoldMessenger.of(context).showSnackBar(

                       SnackBar(
                           backgroundColor: Colors.red
                           ,content: Text(
                           jsonDecode(res.body)["data"]["message"]

                       )));
                 }
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(

                     SnackBar(
                         backgroundColor: Colors.red
                         ,content: Text(
                        tr(StringConstants.problemMessageInCubit)

                     )));
               }
             }on SocketException{

               ScaffoldMessenger.of(context).showSnackBar(

                   SnackBar(
                       backgroundColor: Colors.red
                       ,content: Text(
                       tr(StringConstants.noInternet)

                   )));

             }catch(e ){

               ScaffoldMessenger.of(context).showSnackBar(

                   SnackBar(
                       backgroundColor: Colors.red
                       ,content: Text(
                       tr(StringConstants.problemMessageInCubit)

                   )));
             }
           },
           child:Container(
             margin: EdgeInsets.symmetric(
               vertical: 20,
               horizontal: 30
             ),
             padding: EdgeInsets.symmetric(
               vertical: 4
             ),
             decoration: BoxDecoration (
               borderRadius: BorderRadius.circular(15) ,
               color: Colors.red
             ),
             child: Center(
               child: Text(tr(StringConstants.deleteAccount),
               style: TextStyle(
                 fontSize: 16,
                 color: MyColors.myWhite
               ),
               ),
             ),
           ) ,

         )

                    :SizedBox()
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class IconAndTitleListTile extends StatelessWidget {
  const IconAndTitleListTile(
      {Key? key,
      required this.iconImage,
      required this.title,
      required this.textColor,
      this.onTap})
      : super(key: key);

  final String iconImage;

  final String title;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: FittedBox(
        child: SvgPicture.asset(
          iconImage,
          width: 30,
          height: 30,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }
}

class ListOfIconAndTitle extends StatefulWidget {
  ListOfIconAndTitle({Key? key}) : super(key: key);

  @override
  State<ListOfIconAndTitle> createState() => _ListOfIconAndTitleState();
}

class _ListOfIconAndTitleState extends State<ListOfIconAndTitle> {


  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> titleAndIcon = [
      {"title": tr(StringConstants.main), "icon": PhotosConstants.homeIconDrawer},
      {
        "title": tr(StringConstants.aboutUs),
        "icon": PhotosConstants.aboutUsIconDrawer
      },
      {
        "title": tr(StringConstants.albumOrder),
        "icon": PhotosConstants.albumIconDrawer
      },
      {
        "title": tr(StringConstants.orderQuery),
        "icon": PhotosConstants.orderQueryIconDrawer
      },
      {
        "title": tr(StringConstants.ourServices),
        "icon": PhotosConstants.ourServiceAndAdvantageIconDrawer
      },
      {
        "title": tr(StringConstants.bouquetOrder),
        "icon": PhotosConstants.bouquetReservationIconDrawer
      },
      {
        "title": tr(StringConstants.ourAdvantages),
        "icon": PhotosConstants.ourServiceAndAdvantageIconDrawer
      },
      {
        "title": tr(StringConstants.reversedBouquets),
        "icon": PhotosConstants.bouquetReservationIconDrawer
      },
      {
        "title": tr(StringConstants.works),
        "icon": PhotosConstants.ourWorksIconDrawer
      },
      {
        "title": tr(StringConstants.whatSay),
        "icon": PhotosConstants.whatSayIconDrawer
      },
      {
        "title": tr(StringConstants.freqAskedQuestions),
        "icon": PhotosConstants.questionIconDrawer
      },
      {
        "title": tr(StringConstants.allRequests),
        "icon": PhotosConstants.ourWorksIconDrawer
      },
      {
        "title": tr(StringConstants.myPoints),
        "icon": PhotosConstants.questionIconDrawer
      },
      {
        "title": tr(StringConstants.changeLanguage),
        "icon": PhotosConstants.worldIconDrawer
      },
      {
        "title": tr(StringConstants.cart),
        "icon": PhotosConstants.shoppingIconDrawer
      },
      {
        "title": tr(StringConstants.contactUs),
        "icon": PhotosConstants.contactUsIconDrawer
      },
      {
        "title": tr(StringConstants.logOut),
        "icon": PhotosConstants.logOutIconDrawer
      },
    ];
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (ctx, state) {},
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 3),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return index == titleAndIcon.length - 1 && token == null
                  ? null
                  : IconAndTitleListTile(
                      onTap: () {
                        navigateToFromDrawer(context: context, index: index);
                      },
                      textColor: MyColors.primaryColor,
                      iconImage: titleAndIcon[index]["icon"]!,
                      title: titleAndIcon[index]["title"]!);
            },
            itemCount: titleAndIcon.length,
          );
        });
  }
}

navigateToFromDrawer({required BuildContext context, required int index}) async{
  if (index == 0) {
    BlocProvider.of<HomeCubit>(context)
        .changeCurrentIndexForBottomNavBar(index: 0);
    Navigator.pop(context);
  } else if (index == 1) {

      Navigator.of(context).push(PageTransition(
        child: const EveScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 2) {
    if (token == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      BlocProvider.of<AlbumDetailsRowCubit>(context).changeIndexOfSelectedRequestOfAlbum(indexOfSelectedRequestOfAlbum: 0);

      Navigator.of(context).push(PageTransition(
        child: const AlbumSpecificationScreen(
          home: HomeOrNot.not,
        ),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 3) {

      Navigator.of(context).push(PageTransition(
        child: OrderQueryScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 7) {
    if (token == null || userNamee == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      Navigator.of(context).push(PageTransition(
        child: const ReservedBouquets(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 8) {

      Navigator.of(context).push(PageTransition(
        child: const OurWorksScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 11) {
    if (token == null || userNamee == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      Navigator.of(context).push(PageTransition(
        child: const AllRequestsScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 12) {
    if (token == null || userNamee == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      Navigator.of(context).push(PageTransition(
        child: const PointsScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 15) {
    Navigator.of(context).push(PageTransition(
      child: const ContactUsScreen(),
      type: PageTransitionType.bottomToTop,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 500),
    ));
  } else if (index == 10) {
    Navigator.of(context).push(PageTransition(
      child: const FreqAskedQuestionsScreen(),
      type: PageTransitionType.bottomToTop,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 500),
    ));
  } else if (index == 9) {

      Navigator.of(context).push(PageTransition(
        child: const WhatSayScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 14) {
    if (token == null || userNamee == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      Navigator.of(context).push(PageTransition(
        child: const CartScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 13) {
    Navigator.of(context).push(PageTransition(
      child: const LanguageScreen(),
      type: PageTransitionType.bottomToTop,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 500),
    ));
  } else if (index == 6) {

      Navigator.of(context).push(PageTransition(
        child: const OurAdvantagesScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 4) {

      Navigator.of(context).push(PageTransition(
        child: const OurServicesScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));

  } else if (index == 4 || index == 6) {
    // Navigator.of(context).push(PageTransition(
    //   child: const MyServices(), type: PageTransitionType.bottomToTop ,
    //   duration: const Duration(seconds: 1),
    //   reverseDuration: const Duration(milliseconds: 500),
    //
    // ));
  } else if (index == 5) {
    if (token == null || userNamee == null) {
      Navigator.pushNamed(context, LoginPage.id);
    } else {
      Navigator.of(context).push(PageTransition(
        child: const BouquetFirstScreen(),
        type: PageTransitionType.bottomToTop,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500),
      ));
    }
  } else if (index == 16) {

    // BlocProvider.of<AuthCubit>(context).removeShared();

    restartLogOut(context);


  }
}
void restartLogOut(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => RestartWidget(child: LoginPage(
      loginAgainOrNot:true,

    ))),
        (Route<dynamic> route) => false,
  );
}
void restartLogin(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => RestartWidget(child: LoginPage(
      logoutOrNot:true,

    ))),
        (Route<dynamic> route) => false,
  );
}
