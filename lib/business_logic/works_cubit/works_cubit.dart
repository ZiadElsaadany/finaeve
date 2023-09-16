import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/works_cubit/works_states.dart';
import '/peresentation/models/woks_model.dart';
import '/peresentation/models/works_department_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

class WorksCubit extends Cubit<WorksStates> {
  WorksCubit() : super(WorksInitial());

  int worksItemIndex = 0;

  changeWorksItemIndex({required int index}) {
    worksItemIndex = index;
    emit(ChangeItemState());
  }

  restartWorksItemIndex() {
    worksItemIndex = 0;
    emit(RestartChangeItemState());
  }

  List<WorksDepartmentModel> worksDepartments = [];

  Future<void> getWorksDepartments() async {
    emit(WorksDepartmentLoading());
    try {
      http.Response res =
          await http.get(Uri.parse(ApiConstants.worksDepartments),
              headers:
              {"Accept-Language": "$loc"}
          );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          worksDepartments = List<WorksDepartmentModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => WorksDepartmentModel.fromJson(e)));

          emit(WorksDepartmentLoaded());
        } else {
          emit(WorksDepartmentFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(WorksDepartmentFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(WorksDepartmentFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(WorksDepartmentFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  List<WorksModel> works = [];

  getWorks({required int id}) async {
    emit(WorksLoading());
    try {
      http.Response res =
          await http.get(Uri.parse("${ApiConstants.productsForWorks}?id=$id"),
              headers:
              {"Accept-Language": "$loc"}
          );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          works = List<WorksModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => WorksModel.fromJson(e)));
          print(works[0].toString());

          emit(WorksLoaded());
        } else {
          emit(WorksFailure(message: "Problem went Wrong"));
        }
      } else {
        emit(WorksFailure(message: "Problem went Wrong"));
      }
    } on SocketException {
      emit(WorksFailure(message: "No Internet"));
    } catch (e) {
      emit(WorksFailure(message: "Problem went Wrong"));
    }
  }
}
