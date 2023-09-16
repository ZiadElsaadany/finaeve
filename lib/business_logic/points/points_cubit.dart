import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/peresentation/models/points.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../utilities/constants/string_constants.dart';
part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(PointsInitial());

  int selectedTileIndex = -1;
  int index = -1;
  int currentPage = 1;
   int numberOfPages=1;
  List<PointsModel> json=[];

  Future<void> getPoints() async {
    emit(LoadingPointsState());
    try {
      http.Response res = await http.get(Uri.parse(
          '${ApiConstants.getPoints}access-token=$token&page=$currentPage'),
          headers:
          {"Accept-Language": "$loc"}
      );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {

          currentPage = jsonDecode(res.body)["data"][0]["_meta"]["currentPage"];
          numberOfPages =
          (jsonDecode(res.body)["data"][0]["_meta"]["NumberOfPage"]);
           json += List<PointsModel>.from(
              (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
                return PointsModel.fromJson(e);
              }));
          emit(PointsLoaded(points: json));
          emit(SuccessPointsState());
        } else {
          emit(ErrorPointsState(tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(ErrorPointsState(tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(ErrorPointsState(tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(ErrorPointsState(tr(StringConstants.problemMessageInCubit)));
    }
  }

  selectedFun(int index, int selectedTileIndex) {
    this.index = index;
    this.selectedTileIndex = selectedTileIndex;
    emit(IsSelectedPointsState());
  }
}
