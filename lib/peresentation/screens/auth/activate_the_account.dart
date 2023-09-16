import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/business_logic/auth_cubit/auth_states.dart';
import '/peresentation/screens/auth/login.dart';
import '/peresentation/widgets/shared_widgets/elevated_button.dart';
import '/peresentation/widgets/shared_widgets/header_text.dart';
import '/utilities/constants/colors.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/text_form_field.dart';

class ActivateTheAccountScreen extends StatefulWidget {
  ActivateTheAccountScreen({Key? key,required this.phone}) : super(key: key);
  static const String id = 'activate screen';
  final String   phone ;

  @override
  State<ActivateTheAccountScreen> createState() => _ActivateTheAccountScreenState();
}

class _ActivateTheAccountScreenState extends State<ActivateTheAccountScreen> {
  TextEditingController _phoneOrEmailController = TextEditingController();

  TextEditingController _activateCodeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   setState(() {
     _phoneOrEmailController.text = widget.phone ;
   });
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              HeaderImage(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 30),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.myWhite,
                    )),
              )
            ],
          ),
          Expanded(
            flex: 3,
            child: BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {
    if(state is ActivateFailure )  {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(state.activateFailure)));
    }else if(state is ActivateSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(state.activateSuccess)));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return    const LoginPage();
      }));
    }
  },
  builder: (context, state) {
    return ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                children: [
                   HeaderText(
                    text: tr(StringConstants.activateAccount),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.025,
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.myWhite),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormFieldTemplate(

                              prefixIcon: const Icon(Icons.phone),
                              hintText: tr(StringConstants.phoneNumOrEmail),
                              validator: (value) => value!.isEmpty
                                  ? tr(StringConstants.pleaseEnterPhoneNumOrEmail)
                                  : null,
                              controller: _phoneOrEmailController,
                              type: TextInputType.text,

                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            TextFormFieldTemplate(

                              prefixIcon: const Icon(Icons.person),
                              hintText:tr(StringConstants.activateAccountCode),
                              validator: (value) => value!.isEmpty
                                  ? tr(StringConstants.pleaseEnterActivateAccountCode)
                                  : null,
                              controller: _activateCodeController,
                              type: TextInputType.phone,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height:
                    MediaQuery.of(context).size.height * 0.1,
                  ),
               state is ActivateLoading ?  const Center(
                 child: CircularProgressIndicator(
                   color: MyColors.primaryColor,
                 ),
               ):    ElevatedButtonTemplate(
                      buttonText:tr(StringConstants.activateAccount),
                      buttonColor: MyColors.primaryColor,
                      onPressed: () {
                        print(_phoneOrEmailController.text  );
                        if(_formKey.currentState!.validate()) {

                          BlocProvider.of<AuthCubit>(context).activate(email: _phoneOrEmailController.text, activation_code: _activateCodeController.text);

                        }
                      })
                ]);
  },
),
          ),
        ],
      ),
    );
  }
}
