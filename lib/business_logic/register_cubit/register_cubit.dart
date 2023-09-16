import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> postUser(
      {required String name,
      required String phone,
      required String password,
      required String rePassword,
      required String fullName,
      required String address}) async {
    emit(RegisterLoading());
    try {
      http.Response response =
          await http.post(Uri.parse(ApiConstants.register), body: {
        "name": name,
        "username": fullName,
        "password": password,
        "password_repeat": rePassword,
        "address": address,
        "mobile": phone
      },
              headers:
              {"Accept-Language": "$loc"}
          );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          emit(RegisterLoaded(
              message: jsonDecode(response.body)["data"][0]["message"]));
        } else {
          emit(RegisterFailure(
              message: jsonDecode(response.body)["data"][0]["message"]));
        }
      } else {
        emit(RegisterFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on Socket {
      emit(RegisterFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(RegisterFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
