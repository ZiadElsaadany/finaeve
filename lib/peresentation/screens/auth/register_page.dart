import 'package:easy_localization/easy_localization.dart';
import '/business_logic/register_cubit/register_cubit.dart';
import '/peresentation/screens/auth/activate_the_account.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';
import '../../widgets/shared_widgets/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _userNameController = TextEditingController();

  final _passController = TextEditingController();

  final _confirmPassController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneNumController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _userNameController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _addressController.dispose();
    _phoneNumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: Colors.green,
              content: Text(state.message)));

          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return  ActivateTheAccountScreen(
              phone: _phoneNumController.text,
            );
          }));        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text(state.message)));
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is RegisterLoading,
          child: Scaffold(
            body: AbsorbPointer(
              absorbing: state is RegisterLoading,
              child: Column(
                children: [
                  Stack(
                    children: [
                      const HeaderImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 30
                        ),
                        child: IconButton(onPressed: ( ) {
                          Navigator.pop(context);
                        } , icon: Icon(Icons.arrow_back_ios,
                          color: MyColors.myWhite,
                        )),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             HeaderText(
                              text: tr(StringConstants.register),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormFieldTemplate(
                                    prefixIcon: const Icon(Icons.person),
                                    hintText: tr(StringConstants.theName),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterTheName)
                                        : null,
                                    controller: _nameController,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextFormFieldTemplate(
                                    prefixIcon: const Icon(Icons.person),
                                    hintText:tr( StringConstants.userName),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterUserName)
                                        : null,
                                    controller: _userNameController,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextFormFieldTemplate(
                                    type: TextInputType.phone,
                                    prefixIcon: const Icon(Icons.phone),
                                    hintText:tr(StringConstants.phone),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterPhoneNum)
                                        : null,
                                    controller: _phoneNumController,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextFormFieldTemplate(
                                    prefixIcon: const Icon(Icons.home),
                                    hintText: tr(StringConstants.theAddress),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterTheAddress)
                                        : null,
                                    controller: _addressController,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextFormFieldTemplate(
                                    hintText:tr( StringConstants.pass),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterThePass)
                                        : null,
                                    controller: _passController,

                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  TextFormFieldTemplate(
                                    hintText: tr(StringConstants.pass),
                                    validator: (value) => value!.isEmpty
                                        ? tr(StringConstants.pleaseEnterThePass)
                                        : null,
                                    controller: _confirmPassController,

                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  state is RegisterLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: MyColors.primaryColor,
                                          ),
                                        )
                                      : ElevatedButtonTemplate(
                                          buttonText: tr(StringConstants.register),
                                          buttonColor: MyColors.primaryColor,
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<
                                                  RegisterCubit>(context)
                                                  .postUser(
                                                  name: _nameController
                                                      .text,
                                                  phone:
                                                  _phoneNumController
                                                      .text,
                                                  password:
                                                  _passController
                                                      .text,
                                                  rePassword:
                                                  _confirmPassController
                                                      .text,
                                                  fullName:
                                                  _userNameController
                                                      .text,
                                                  address:
                                                  _addressController
                                                      .text);

                                            }
                                          })
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
