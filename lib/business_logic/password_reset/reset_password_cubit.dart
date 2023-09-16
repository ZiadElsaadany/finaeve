import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  Future<void> sendCodeToMobile({
    required String mobile,
  }) async {
    emit(ResetPasswordLoading());
    try {
      http.Response res =
          await http.post(Uri.parse(ApiConstants.passReset), body: {
        "mobile": mobile,
      },
              headers:
              {"Accept-Language": "$loc"}
          );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] != 1) {
          emit(ResetPasswordFailure(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(ResetPasswordSuccess(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      } else {
        emit(ResetPasswordFailure(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ResetPasswordFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(ResetPasswordFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
