import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/all_requests_cubit/all_request_states.dart';
import '/peresentation/models/show_request_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../peresentation/models/my_orders_archieve_model.dart';
import '../../utilities/constants/string_constants.dart';
import '../auth_cubit/auth_cubit.dart';

class AllRequestCubit extends Cubit<AllRequestStates> {
  AllRequestCubit() : super(AllRequestInitial());

  int selectedAllRequests = 0;
  ShowRequestModel? showRequestModel = null;

  changeIndexOfAllRequests({required int index}) {
    selectedAllRequests = index;
    emit(ChangeRequestSelect());
  }

  List<MyOrdersArchive> archiveOrders = [];
  List<MyOrdersArchive> inProgressOrders = [];
  List<MyOrdersArchive> endedOrders = [];
  int currentPage=1;
  int numOfPage=1;
  // int? totalCount;

  Future<void> getBouquetsInformation({required int indexOfRequest,required String endPoint}) async {

    try {
      http.Response res = await http.get(Uri.parse('${ApiConstants.baseUrl}/${endPoint}?access-token=$token&page=$currentPage'),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          currentPage=jsonDecode(res.body)["data"][0]["_meta"]["currentPage"];
          numOfPage=jsonDecode(res.body)["data"][0]["_meta"]["NumberOfPage"];
          // totalCount=jsonDecode(res.body)["data"][0]["_meta"]["totalCount"];
          if(indexOfRequest == 0  ) {
            archiveOrders = archiveOrders + List<MyOrdersArchive>.from(
                (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
                  return MyOrdersArchive.fromJson(e);
                }));
          }else if(indexOfRequest == 1 )  {
            inProgressOrders = inProgressOrders + List<MyOrdersArchive>.from(
                (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
                  return MyOrdersArchive.fromJson(e);
                }));
          }  else if( indexOfRequest  == 2){
            endedOrders = endedOrders + List<MyOrdersArchive>.from(
                (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
                  return MyOrdersArchive.fromJson(e);
                }));
          }
          print(archiveOrders.length);
          emit(SuccessMyOrdersArchiveState());
          emit(MyOrdersArchiveStateLoaded(archiveOrders: archiveOrders, inProgressOrders: inProgressOrders, endedOrders: endedOrders));
        } else {
          emit(FailureMyOrdersArchiveState(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(FailureMyOrdersArchiveState(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(
          FailureMyOrdersArchiveState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureMyOrdersArchiveState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  List values = [];

  Future<void> showRequestDetails({
    required int id,
  }) async {
    emit(LoadingShowRequest());
    try {
      http.Response res = await http.get(
        Uri.parse("${ApiConstants.showOrder}?access-token=$token&id=$id"),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          showRequestModel =
              ShowRequestModel.fromJson(jsonDecode(res.body)["data"][0]);
          Map<String, dynamic> map = jsonDecode(res.body)["data"][0];
          values = map.values.toList();

          emit(SuccessShowRequest());
        } else {
          emit(FailureShowRequest(
              message: jsonDecode(res.body)["data"]["message"]));
        }
      }
    } on SocketException {
      emit(FailureShowRequest(message: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(FailureShowRequest(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}

