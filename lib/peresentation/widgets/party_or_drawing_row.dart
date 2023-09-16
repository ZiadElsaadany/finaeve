import 'package:easy_localization/easy_localization.dart';
import '/peresentation/album/album_specifications_page.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/widgets/album_order_widgets/party_drawing_template.dart';
import '/utilities/constants/images.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/album_order/album_details_row_cubit.dart';
import '../../business_logic/auth_cubit/auth_cubit.dart';
import '../screens/bouquet/bouquet_list_view.dart';

class PartyOrDrawingRequestRow extends StatelessWidget {
  const PartyOrDrawingRequestRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: () {
              if (token == null) {
                Navigator.pushNamed(context, LoginPage.id);
              } else {
                BlocProvider
                    .of<AlbumDetailsRowCubit>(context)
                    .changeIndexOfSelectedRequestOfAlbum(indexOfSelectedRequestOfAlbum: 4);
                Navigator.of(context).pushNamed(AlbumSpecificationScreen.id);
              }
            },
            child:  PartyDrawingTemplate(
              image: ImageConstants.art,
              txt: tr(StringConstants.paintOrder),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
              onTap: () {
                if (token == null) {
                  Navigator.pushNamed(context,LoginPage.id);
                } else {
                  Navigator.of(context).pushNamed(BouquetFirstScreen.id);
                }
              },
              child:  PartyDrawingTemplate(
                image: ImageConstants.camera,
                txt: tr(StringConstants.partyOrder),
              )),
        ),
      ],
    );
  }
}
