import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/peresentation/widgets/shared_widgets/text_form_field.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/password_reset/reset_password_cubit.dart';
import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';
import 'change_password_page.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key}) : super(key: key);
  static const String id = 'forgetPass';

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumController = TextEditingController();

  @override
  void dispose() {
    _phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        text: tr(StringConstants.losPass),
                      ),
                       Text(
                        tr(StringConstants.losMessage),
                        style: TextStyle(color: MyColors.primaryColor,
                        fontSize: 16
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormFieldTemplate(
                          prefixIcon: const Icon(Icons.phone),
                          hintText: tr(StringConstants.phone),
                          type: TextInputType.phone,
                          validator: (value) => value!.isEmpty ? '*' : null,
                          controller: _phoneNumController,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                        listener: (context, state) {
                          if (state is ResetPasswordFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ));
                          } else if (state is ResetPasswordSuccess) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordPage()));
                          }
                        },
                        builder: (context, state) {
                          return state is ResetPasswordLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.primaryColor,
                                  ),
                                )
                              : ElevatedButtonTemplate(
                                  buttonText: tr(StringConstants.send),
                                  buttonColor: MyColors.primaryColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                    BlocProvider.of<ResetPasswordCubit>(context)
                                        .sendCodeToMobile(
                                            mobile: _phoneNumController.text);
                                  });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
