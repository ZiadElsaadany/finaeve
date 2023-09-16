import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/query_cubit/query_states.dart';
import '/peresentation/models/query_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

class QueryCubit extends Cubit<QueryStates> {
  QueryCubit() : super(InitialQueryState());

  QueryModel? queryModel;

  Future<void> postQuery({required String id}) async {
    emit(LoadingQueryState());
    try {
      http.Response response =
          await http.post(Uri.parse(ApiConstants.postQuery), body: {"id": id},
              headers:
              {"Accept-Language": "$loc"}
          );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          if (jsonDecode(response.body)["data"][0]["status"] == "0") {
            emit(FailureQueryState(
                message: jsonDecode(response.body)["data"][0]["message"]));
            return;
          }
          queryModel =
              QueryModel.fromJson(jsonDecode(response.body)["data"][0]);
          print(queryModel);
          emit(SuccessQueryState());
        } else {
          emit(FailureQueryState(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(FailureQueryState(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(FailureQueryState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureQueryState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
