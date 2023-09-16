import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/slider/slider_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../peresentation/models/slider_model.dart';
import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

class SliderCubit extends Cubit<SliderStates> {
  SliderCubit() : super(InitialSliderState());

  int indexOfSlider = 0;

  void changeIndexOfSlider(int index) {
    indexOfSlider = index;
    emit(ChangeSliderIndexState());
  }

  List<SliderModel> bottomSlider = [];

  Future<void> sliderBottomHome() async {
    try {
      http.Response res = await http.get(Uri.parse(ApiConstants.sliderBottom),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          bottomSlider = List<SliderModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => SliderModel.fromJson(e)));
          emit(BottomSliderStateSuccess());
        } else {
          emit(BottomSliderStateFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(BottomSliderStateFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on Socket {
      emit(
          BottomSliderStateNoInternet(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(BottomSliderStateFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }


}
