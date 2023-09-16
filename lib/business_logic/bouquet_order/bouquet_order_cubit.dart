import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../utilities/constants/string_constants.dart';

part 'bouquet_order_state.dart';

class BouquetOrderCubit extends Cubit<BouquetOrderState> {
  BouquetOrderCubit() : super(BouquetOrderInitial());

  postBouquetOrder({
    required int id,
    required String price,
    required String date,
    required String time,
    // required int quantity,
  }) async {
    emit(LoadingPostBouquetOrderState());
    try {
      http.Response res = await http.post(
          Uri.parse(
              '${ApiConstants.postBouquetOrderEndPoint}access-token=$token'),
          body: {
            "plan_id": "$id",
            "price": price,
            "date": date,
            "time": time,
            // "quantity": quantity
          },
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(SuccessPostBouquetOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(FailurePostBouquetOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      } else {
        emit(FailurePostBouquetOrderState(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(FailurePostBouquetOrderState(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailurePostBouquetOrderState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
