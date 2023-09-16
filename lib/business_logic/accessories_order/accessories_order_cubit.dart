import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/utilities/constants/api_constants.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'accessories_order_state.dart';

class AccessoriesOrderCubit extends Cubit<AccessoriesOrderState> {
  AccessoriesOrderCubit() : super(AccessoriesOrderInitial());
  postChangePointsRequest() async {
    emit(LoadingAccessoriesOrderState());
    try{
      http.Response res = await http.post(Uri.parse(
          '${ApiConstants.accessoriesOrder}access-token=$token'),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(SuccessAccessoriesOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          emit(ErrorAccessoriesOrderState(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      }else {
        emit(ErrorAccessoriesOrderState(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ErrorAccessoriesOrderState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(ErrorAccessoriesOrderState(message: tr(StringConstants.problemMessageInCubit)));
    }

  }
}
