import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';
part 'chnage_password_state.dart';

class ChnagePasswordCubit extends Cubit<ChnagePasswordState> {
  ChnagePasswordCubit() : super(ChnagePasswordInitial());
  Future<void> changePassword({
    required String code,
    required String password,
  }) async {
    emit(ChnagePasswordLoading());
    try {
      http.Response res =
          await http.post(Uri.parse(ApiConstants.changePassword), body: {
        "token": code,
        "password": password,
      },
              headers:
              {"Accept-Language": "$loc"}
          );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["data"][0]["status"] == 1) {
          emit(ChnagePasswordLoaded(
              message: jsonDecode(res.body)["data"][0]["message"]));

        } else {
          emit(ChnagePasswordFailure(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      } else {
        emit(ChnagePasswordFailure(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ChnagePasswordFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      debugPrint(e.toString());
      emit(ChnagePasswordFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
