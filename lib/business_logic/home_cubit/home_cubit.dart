import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/home_cubit/home_states.dart';
import '/peresentation/models/slider_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  int currentIndex = 0;

  void changeCurrentIndexForBottomNavBar({required int index}) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  bool eye = false;

  void changeEye() {
    eye = !eye;
    emit(ChangeLoginPasswordEyes());
  }

  List<SliderModel> sliders = [];

  Future<void> getSliders() async {
    emit(GetSliderLoading());
    try {
      http.Response res = await http.get(Uri.parse(ApiConstants.getSliders),
          headers:
          {"Accept-Language": "$loc"}
      );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          //
          // List<MovieModel>.from((response.data["results"] as List).map(
          //      (e) => MovieModel.fromJson(e),
          // ));

          sliders = List<SliderModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => SliderModel.fromJson(e)));

          emit(GetSliderSuccess());
        } else {
          emit(GetSliderFailure(message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(GetSliderFailure(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(GetSliderFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetSliderFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
