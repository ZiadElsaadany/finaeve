import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/auth/login.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/change_password/chnage_password_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../widgets/shared_widgets/elevated_button.dart';
import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';
import '../../widgets/shared_widgets/text_form_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ChnagePasswordCubit, ChnagePasswordState>(
          listener: (context, state) {
            if (state is ChnagePasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            } else if (state is ChnagePasswordLoaded) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage()));
            }
          },
  builder: (context, state) {
    return Column(
          children: [
            Stack(
              children: [
                const HeaderImage(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: MyColors.myWhite,
                    ))
              ],
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                       HeaderText(
                        text: tr(StringConstants.changePass),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormFieldTemplate(
                              prefixIcon: const Icon(Icons.phone),
                              hintText:tr(StringConstants.passRecoveryCode),
                              validator: (value) => value!.isEmpty ? '*' : null,
                              controller: codeController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormFieldTemplate(
                              prefixIcon: const Icon(Icons.password),
                              hintText: tr(StringConstants.pass),
                              validator: (value) => value!.isEmpty ? '*' : null,
                              controller: passController,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormFieldTemplate(
                              prefixIcon: const Icon(Icons.password),
                              hintText: tr(StringConstants.confirmPass),
                              validator: (value) => value!.isEmpty ? '*' : null,
                              controller: confirmPassController,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                state  is ChnagePasswordLoading ?  Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                ):        ElevatedButtonTemplate(
                    buttonText: tr(StringConstants.changePass),
                    buttonColor: MyColors.primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (passController.text ==
                            confirmPassController.text) {
                          BlocProvider.of<ChnagePasswordCubit>(context)
                              .changePassword(
                              password: passController.text,
                              code: codeController.text);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                            content: Text(
                              tr(StringConstants.doesntMatch),
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }

                    })
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  },
),
      ),
    );
  }
}
