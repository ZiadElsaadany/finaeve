import 'package:easy_localization/easy_localization.dart';
import '/business_logic/album_order/album_details_row_cubit.dart';
import '/peresentation/album/album_specifications_page.dart';
import '/peresentation/screens/auth/login.dart';
import '/utilities/constants/api_constants.dart';
import '/utilities/constants/images.dart';
import '/utilities/constants/photos.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../no_login_widget.dart';

class AlbumRequestRow extends StatelessWidget {
  const AlbumRequestRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (token == null) {
          Navigator.pushNamed(context, LoginPage.id);
        } else {
          BlocProvider.of<AlbumDetailsRowCubit>(context).changeIndexOfSelectedRequestOfAlbum(indexOfSelectedRequestOfAlbum: 0);
          Navigator.pushNamed(context,AlbumSpecificationScreen.id);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(8),
                bottomStart: Radius.circular(8),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.015, ),
                height: MediaQuery.of(context).size.height * 0.1,
                color: MyColors.myYellow,
                child: Image.asset(
                  ImageConstants.album,
                  scale: MediaQuery.of(context).size.height * 0.002,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius:  const BorderRadiusDirectional.only(
                topEnd: Radius.circular(8),
                bottomEnd: Radius.circular(8),
              ),
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0001,),
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: MyColors.primaryColor,
                  child:  Center(
                    child:  Text(
                      tr(StringConstants.albumOrder),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),

                    ).tr()
                  )),
            ),
          ),
        ],
      ),
    ) ;
  }
}
