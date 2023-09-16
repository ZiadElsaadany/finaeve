import 'package:easy_localization/easy_localization.dart';
import '/business_logic/slider/slider_states.dart';
import '/peresentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../business_logic/slider/slider_cubit.dart';
import '../../../main.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);
  static const String id = 'languageScreen';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    String language = "language";
    return Scaffold(
      backgroundColor: MyColors.colorWhite,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        title: SvgPicture.asset(
          PhotosConstants.eveLogo,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.2,
          height: 50,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15,
          ),
          child: BlocConsumer<SliderCubit, SliderStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tr(language),
                    style: const TextStyle(
                        color: MyColors.primaryColor, fontSize: 20),
                  ),
                  Image.asset(
                    ImageConstants.rectangleDesign,
                    width: 23,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
              GestureDetector(
              onTap:  ()async{

                  EasyLocalization.of(context)?.setLocale(Locale("ar"));
                  final sharedPref = await SharedPreferences.getInstance();
                  await sharedPref.setString(
                      "loc", "ar");
                  loc = sharedPref.getString("loc")!;

                print(loc);
                setState(() {

                });
                  restartApp(context);

              },
              child: Container(
              decoration: BoxDecoration(
              color: MyColors.myWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MyColors.deepGray),
              ),
              padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Row(
              children: [
              CircleAvatar(
              radius: 13,
              backgroundColor:    context.locale == const Locale("ar")
              ? MyColors.primaryColor
                  : MyColors.grayText,
              child: const Icon(
              Icons.done,
              size: 20,
              color: MyColors.colorWhite,
              ),
              ),
              SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
              tr(StringConstants.arabicLanguage),
              style: const TextStyle(color:
              MyColors.primaryColor,
              fontSize: 16
              ),
              ),
              ],
              ),
              ),
              ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap:  () async{
  EasyLocalization.of(context)?.setLocale(Locale("en"));
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString(
      "loc", "en");
  loc = sharedPref.getString("loc")!;
  setState(() {

  });
  restartApp(context);
print(loc);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.myWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MyColors.deepGray),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor:    context.locale == const Locale("en")
                                ? MyColors.primaryColor
                                : MyColors.grayText,
                            child: const Icon(
                              Icons.done,
                              size: 20,
                              color: MyColors.colorWhite,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            tr(StringConstants.englishLanguage),
                            style: const TextStyle(color:
                            MyColors.primaryColor,
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
void restartApp(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => RestartWidget(child: HomeScreen())),
        (Route<dynamic> route) => false,
  );
}
class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({required this.child});

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state = context.findAncestorStateOfType<_RestartWidgetState>();
    if (state != null) {
      state.restartApp();
    }
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}