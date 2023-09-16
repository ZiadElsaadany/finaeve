import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';
import '../auth_cubit/auth_cubit.dart';
part 'paint_order_state.dart';

class PaintOrderCubit extends Cubit<PaintOrderState> {
  PaintOrderCubit() : super(PaintOrderInitial());
  postChangePointsRequest() async {
    emit(LoadingPaintOrderState());
    try{
      http.Response res = await http.post(Uri.parse(
          '${ApiConstants.postChangePointsPaintOrderCubit}access-token=$token'),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(SuccessPaintOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(ErrorPaintOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      }else {
        emit(ErrorPaintOrderState(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ErrorPaintOrderState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(ErrorPaintOrderState(message: tr(StringConstants.problemMessageInCubit)));
    }

  }
}
