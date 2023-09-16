import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/our_services/our_services_cubit.dart';
import '/peresentation/album/album_specifications_page.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/screens/frequentaly_asked_questions/freq_asked_question_screen.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utilities/constants/colors.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);
  static const String id = 'ItemDetailsScreen';
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.03,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: BlocConsumer<OurServicesCubit, OurServicesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: MyColors.primaryColor, fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(parseHtmlString(text),
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                            color: MyColors.myBlack, fontSize: 18,),
                      ),
                      const Spacer(),
                      ElevatedButtonTemplate(buttonText: tr(StringConstants.serviceRequest), buttonColor: MyColors.primaryColor, onPressed: (){

                        if(token==null ) {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx ) {
                            return LoginPage();
                          } ));
                        }else{
                          Navigator.of(context).push(PageTransition(
                            child: const AlbumSpecificationScreen(),
                            type: PageTransitionType.bottomToTop,
                            duration: const Duration(seconds: 1),
                            reverseDuration: const Duration(milliseconds: 500),
                          ));
                        }

                      }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
