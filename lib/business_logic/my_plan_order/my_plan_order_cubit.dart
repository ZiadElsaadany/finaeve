import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/peresentation/models/my_plan_order.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';
part 'my_plan_order_state.dart';
class MyPlanOrderCubit extends Cubit<MyPlanOrderState> {
  MyPlanOrderCubit() : super(MyPlanOrderInitial());
  int currentPage = 1;
   int numberOfPages=1;
  List<MyPlanOrderModel> myPlanOrder=[];
  Future<void> getMyPlanOrder() async{
    emit(LoadingMyPlanOrderState());

    try{
      http.Response res = await http
          .get(Uri.parse('${ApiConstants.getMyPlanOrder}access-token=$token&page=$currentPage'),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          currentPage = jsonDecode(res.body)["data"][0]["_meta"]["currentPage"];
          numberOfPages =
          (jsonDecode(res.body)["data"][0]["_meta"]["NumberOfPage"]);
          myPlanOrder += List<MyPlanOrderModel>.from(
              (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
                return MyPlanOrderModel.fromJson(e);
              }));
          print(myPlanOrder);
          emit(MyPlanOrderStateLoaded(myPlanOrder: myPlanOrder));
          emit(SuccessMyPlanOrderState());
        } else {
          emit(FailureMyPlanOrderState(message:tr(StringConstants.problemMessageInCubit)));
        }
      }else {
        emit(FailureMyPlanOrderState(message: tr(StringConstants.problemMessageInCubit)));
      }

    }on SocketException {
      emit(FailureMyPlanOrderState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureMyPlanOrderState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
