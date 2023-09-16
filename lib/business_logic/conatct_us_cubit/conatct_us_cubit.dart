import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/conatct_us_cubit/conact_us_states.dart';
import '/peresentation/models/contact_us_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

class ContactUsCubit extends Cubit<ContactStates> {
  ContactUsCubit() : super(InitialContact());

  ContactUsInformationModel? contactModel;

  getContactInformation() async {
    emit(LoadingContactUsState());
    try {
      http.Response res = await http.get(Uri.parse(ApiConstants.contactUsInfo),
          headers:
          {"Accept-Language": "$loc"}
      );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          contactModel = ContactUsInformationModel.fromJson(
              jsonDecode(res.body)["data"][0]["setting"]);
          print(contactModel);

          emit(SuccessContactUsState());
        } else {
          emit(FailureContactUsState(message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(FailureContactUsState(message:tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(FailureContactUsState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureContactUsState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  postContact({
    required String name,
    required String mobile,
    required String email,
    required String message,
  }) async {
    emit(LoadingPostContactUsState());
    try {
      http.Response res = await http.post(Uri.parse(ApiConstants.postContact),
          body: {
            "name": name,
            "mobile": mobile,
            "email": email,
            "body": message
          },
          headers:
          {"Accept-Language": "$loc"}
      )
    ;

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(SuccessPostContactUsState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(FailurePostContactUsState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      } else {
        emit(FailurePostContactUsState(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(FailurePostContactUsState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailurePostContactUsState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
