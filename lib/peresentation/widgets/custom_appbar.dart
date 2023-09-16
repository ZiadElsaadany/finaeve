import '/business_logic/Lists/lists_cubit.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/cart/cart_cubit.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/screens/cart_screen/cart_screen.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../utilities/constants/colors.dart';
import '../screens/language/language_screen.dart';

customAppBar(context ,{ bool home = false}) {
  return AppBar(
    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    centerTitle: true,
    backgroundColor: MyColors.primaryColor,
    title: SvgPicture.asset(
      PhotosConstants.eveLogo,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height*0.08,
    ),
    actions: [
      Padding(
        padding: const EdgeInsetsDirectional.only(
            end: 15.0),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    child: const LanguageScreen(),
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(seconds: 1),
                    reverseDuration: const Duration(milliseconds: 500),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    PhotosConstants.world,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                )),
            SizedBox(width: 10,),
       home == true?     GestureDetector(
              onTap:  ( ) {
                if (token != null) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (ctx) {
                        return CartScreen();
                      }
                  ));
                }else{
                  Navigator.push(context, MaterialPageRoute(
                      builder: (ctx) {
                        return LoginPage();
                      }
                  ));
                }
              },
              child: BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return state is LoadingCartState? Center(
      child: CircularProgressIndicator(
        color: MyColors.primaryColor,
      ),
    ):       Stack(
                children: [
                  Icon(Icons.shopping_cart,
                  size: 40,
                  ),
                  CircleAvatar(
                    child: Text(
                    BlocProvider.of<CartCubit>(context).count??"0"
                    ,
                    style: TextStyle( fontSize: 10,
                      color: MyColors.myBlack

                    ),
                    ),
                    radius: 12,
                    backgroundColor: MyColors.myYellow,
                  )
                ],
              );
  },
),
            ):SizedBox()

          ],
        ),
      )
    ],
  );
}
