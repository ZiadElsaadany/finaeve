import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/auth_cubit/auth_states.dart';
import '/peresentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/images.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/shared_widgets/text_input_template.dart';

class PasswordScreen extends StatelessWidget {
   PasswordScreen({Key? key}) : super(key: key);


  static  const String id = "PasswordScreen";

  GlobalKey<FormState>  _key = GlobalKey<FormState>();
  TextEditingController passController  = TextEditingController() ;
  TextEditingController confirmPassController  = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context),
      body: BlocConsumer<AuthCubit,AuthStates>(
        listener: (ctx,state) {
          if(state is UpdatePasswordFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content:
            Text(state.passFailure)
            ));
          } else if(state is UpdatePasswordSuccess){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content:
            Text(state.passSuccess)
            ));
          }
        },
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15
            ),
            child: Form(
              key: _key,
              child: ListView(
                children: [
                   Text(tr(StringConstants.pass),
                    style: const TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 20
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Image.asset(ImageConstants.rectangleDesign,
                      width: 23,
                      height: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),



                  const SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   obscureText:  BlocProvider.of<AuthCubit>(context).oldPassVisible,
                  //   style: GoogleFonts.almarai(
                  //       color: MyColors.myBlack.withOpacity(0.6)
                  //   ),
                  //   decoration: inputDecoration(
                  //     x:  BlocProvider.of<AuthCubit>(context).oldPassVisible,
                  //       onPressed: ()  {
                  //         BlocProvider.of<AuthCubit>(context).changeOldPassVisible();
                  //       },
                  //       hintText:tr( StringConstants.oldPass)
                  //
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  TextFormField(
                    controller: passController,
                    validator: (c){
                      if(c==null || c.isEmpty) {
                        return  "*";
                      }
                    },
                    obscureText:  BlocProvider.of<AuthCubit>(context).newPassVisible,

                    style: GoogleFonts.almarai(
                        color: MyColors.myBlack.withOpacity(0.6)
                    ),

                    decoration: inputDecoration(
                        x:  BlocProvider.of<AuthCubit>(context).newPassVisible,
                        onPressed: ()  {
                        BlocProvider.of<AuthCubit>(context).changeNewPassVisible();
                        },
                        hintText: tr(StringConstants.newPass)
                    ),

                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller: confirmPassController,
                    validator: (c){
                      if(c==null || c.isEmpty) {
                        return  "*";
                      }
                    },
                    obscureText:  BlocProvider.of<AuthCubit>(context).confirmPassVisible,

                    style: GoogleFonts.almarai(
                        color: MyColors.myBlack.withOpacity(0.6)
                    ),

                    decoration: inputDecoration(
                        x:  BlocProvider.of<AuthCubit>(context).confirmPassVisible,
                        onPressed: ()  {
                          BlocProvider.of<AuthCubit>(context).changeConfirmPassVisible();
                        },

                        hintText: tr(StringConstants.confirmPass)
                    ),

                  ),

                  const SizedBox(
                    height:200,
                  ),
                state is UpdatePasswordLoading?

                    const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                    )
                    :  MaterialButton(

                    onPressed: ( ) {
                      if(_key.currentState!.validate()){

                        BlocProvider.of<AuthCubit>(context).updatePassword(password: passController.text, newPasswordConfirm: confirmPassController.text);

                      }
                    } ,
                  color: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(tr(StringConstants.saveInfo),
                  style: const TextStyle(
                      color: MyColors.myWhite,
                      fontSize: 18
                  ),
                  ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

InputDecoration   inputDecoration(
    {
      required String hintText ,
      required bool  x,
      required   void Function()? onPressed
    }
    ){
  return InputDecoration(
    suffixIcon: x?
    IconButton(
      onPressed: onPressed ,
      icon: const Icon(Icons.visibility_off,color: Colors.red, ),
    )
        :  IconButton(
onPressed: onPressed ,
icon: const Icon(Icons.visibility,color: Colors.red, ),
),
    hintText: hintText,
    border: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
          color: MyColors.myBlack,
      )
  ) ;
}