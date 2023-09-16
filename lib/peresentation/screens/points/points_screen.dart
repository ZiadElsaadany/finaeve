import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/peresentation/widgets/shared_widgets/header_text.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../business_logic/change_points/change_points_cubit.dart';
import '../../../business_logic/points/points_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../widgets/custom_appbar.dart';
import 'expansion_tile_points.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({Key? key}) : super(key: key);
  static const String id = "PointsScreen";

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      BlocProvider.of<PointsCubit>(context).currentPage =0;

      BlocProvider.of<PointsCubit>(context).json = [] ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderText(text: tr(StringConstants.myPoints)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.025,
                  vertical: MediaQuery.of(context).size.height * 0.025),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.lightGray),
              child: CustomPoints(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
             ExpansionTilePoints(),
          ],
        ),
      ),
    );
  }
}

class CustomPoints extends StatefulWidget {
  const CustomPoints({Key? key}) : super(key: key);

  @override
  State<CustomPoints> createState() => _CustomPointsState();
}

class _CustomPointsState extends State<CustomPoints> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<PointsCubit>(context).getPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePointsCubit, ChangePointsState>(
      listener: (context, state) {
        if (state is SuccessChangePointsState) {

          showDialog(context: context, builder: (ctx) {
            return SizedBox(
                height: 200,
                child:  DonePointsDialog(
                  message: state.message,
                ));
          });
        } else if (state is ErrorChangePointsState) {

          showDialog(context: context, builder: (ctx) {
            return SizedBox(
                height: 200,
                child:  DonePointsDialog(

                  message: state.message,
                ));
          });
        }
      },
      builder: (context, state) {
        return state is LoadingChangePointsState? Center(child: CircularProgressIndicator(
          color: MyColors.primaryColor,
        )) :ElevatedButtonTemplate(
            buttonText: tr(StringConstants.changeMyPoints),
            buttonColor: MyColors.myYellow,
            onPressed: () {
              BlocProvider.of<ChangePointsCubit>(context)
                  .postChangePointsRequest();
            });
      },
    );
  }
}

class DonePointsDialog extends StatelessWidget {
  const DonePointsDialog({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: MyColors.myWhite
              ),
              child:  Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: CircleAvatar(
                          backgroundColor: MyColors.primaryColor,
                          child: IconButton(onPressed: ( ) {
                            Navigator.pop(context);
                          } , icon: Icon(Icons.close,color: Colors.white,)),
                        ),
                      ),
                    ),
                    Spacer(),

                    Text('''${message}''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 16
                      ),
                    ),
                    Spacer(),

                  ],
                ),
              ),
            ),

            Positioned(
                top: 0,
                child: CircleAvatar(
                  backgroundColor: MyColors.primaryColor,
                  radius: 50,
                  child: SvgPicture.asset(
                    PhotosConstants.eveLogo,
                    width: 30,
                    height: 30,
                  ),
                )),

          ],
        ),
      ),
    );
  }
}