import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/auth_cubit/auth_states.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/utilities/constants/photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/string_constants.dart';

class InformationProfileScreen extends StatefulWidget {
  InformationProfileScreen({Key? key}) : super(key: key);

  static const String id = "InformationProfileScreen";

  @override
  State<InformationProfileScreen> createState() => _InformationProfileScreenState();
}

class _InformationProfileScreenState extends State<InformationProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  String? nameee;

  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is UpdateProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.loginFailureMessage)));
            } else if (state is UpdateProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.loginSuccess)));
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                Text(
                  tr(StringConstants.profileInfo),
                  style: const TextStyle(
                      color: MyColors.primaryColor, fontSize: 20),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Image.asset(
                    ImageConstants.rectangleDesign,
                    width: 23,
                    height: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).getImageFromGallery();
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const CircleAvatar(
                          radius: 75,
                          backgroundColor: MyColors.primaryColor,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset("assets/images/itar_profile.png"),
                              SvgPicture.asset(PhotosConstants.uploadPhotoG)
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: MyColors.myWhite,
                        ),
                        BlocProvider.of<AuthCubit>(context).userImgFile == null
                            ? CircleAvatar(
                                radius: 57,
                                backgroundImage:
                                    CachedNetworkImageProvider(avatar??""))
                            : CircleAvatar(
                                foregroundColor: MyColors.primaryColor,
                                radius: 57.0,
                                backgroundImage: FileImage(
                                    BlocProvider.of<AuthCubit>(context)
                                        .userImgFile!)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.myGray),
                      color: MyColors.myGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                   "${ tr(StringConstants.userName)} | ${userNamee}",
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColors.myBlack.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  // controller:nameController ,
                  onChanged: (v) {
                    name = v.trim();
                  },
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColors.myBlack.withOpacity(0.6)),
                  initialValue: name,
                  decoration: inputDecoration(
                      prefixText: "${tr(StringConstants.name)} | "),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.myGray),
                      color: MyColors.myGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "${tr(StringConstants.email)} | $email",
                    style: TextStyle(
                        fontSize: 16,

                        color: MyColors.myBlack.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  // controller:mobileController ,
                  onChanged: (v) {
                    phone = v.trim();
                  },
                  style:TextStyle(
                      color: MyColors.myBlack.withOpacity(0.6),
                    fontSize: 16
                  ),
                  initialValue: "$mobile",

                  decoration: inputDecoration(
                      prefixText: "${tr(StringConstants.phone)} | "),
                ),
                 SizedBox(
                  height:MediaQuery.of(context).size.height*0.04,
                ),
                state is UpdateProfileLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ))
                    : MaterialButton(
                        onPressed: () async {
                          BlocProvider.of<AuthCubit>(context).updateProfile(
                              name: nameee ?? name!,
                              mobile: phone ?? mobile!,
                              file: BlocProvider.of<AuthCubit>(context)
                                          .userImgFile ==
                                      null
                                  ? null
                                  : BlocProvider.of<AuthCubit>(context)
                                      .userImgFile!);
                        },
                        color: MyColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tr(StringConstants.saveInfo),
                            style: const TextStyle(
                                color: MyColors.myWhite, fontSize: 20),
                          ),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}

InputDecoration inputDecoration({required String prefixText}) {
  return InputDecoration(
    prefixText: prefixText,
    border: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: MyColors.myGray));
}
