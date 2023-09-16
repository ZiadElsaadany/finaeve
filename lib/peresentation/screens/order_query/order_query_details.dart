import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/all_requests/all_requests_screen.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';

class OrderQueryDetailsScreen extends StatelessWidget {
   const OrderQueryDetailsScreen({Key? key, required this.number, required this.date, required this.status}) : super(key: key);
static const String id='orderQueryDetails';

final int number;
final String date;
final String status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              const HeaderImage(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0,
                horizontal: 8
                ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       HeaderText(text: tr(StringConstants.orderQuery)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                       ItemOfRequest(
                         date: date,
                         status: status,
                         number: number,
                       ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
