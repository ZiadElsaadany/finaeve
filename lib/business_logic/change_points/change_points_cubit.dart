import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

part 'change_points_state.dart';

class ChangePointsCubit extends Cubit<ChangePointsState> {
  ChangePointsCubit() : super(ChangePointsInitial());

  postChangePointsRequest() async {
    emit(LoadingChangePointsState());
    try{
      http.Response res = await http.post(Uri.parse(
          '${ApiConstants.changePointsEndPoint}access-token=$token'),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(SuccessChangePointsState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(ErrorChangePointsState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      }else {
        emit(ErrorChangePointsState(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ErrorChangePointsState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(ErrorChangePointsState(message: tr(StringConstants.problemMessageInCubit)));
    }

  }
}
