import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/peresentation/models/our_advantages.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

part 'our_advantages_state.dart';

class OurAdvantagesCubit extends Cubit<OurAdvantagesState> {
  OurAdvantagesCubit() : super(OurAdvantagesInitial());
  List<OurAdvantagesModel> ourAdvantageList = [];

  getOurAdvantages() async {
    emit(OurAdvantagesLoadingState());
    try {
      http.Response res = await http
          .get(Uri.parse(ApiConstants.getOurAdvantages),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          ourAdvantageList = List<OurAdvantagesModel>.from(
              (jsonDecode(res.body)["data"][0] as List).map((e) {
            return OurAdvantagesModel.fromJson(e);
          }));
          emit(OurAdvantagesSuccessState());
        } else {
          emit(OurAdvantagesFailureState(message:tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(OurAdvantagesFailureState(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(OurAdvantagesFailureState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(OurAdvantagesFailureState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
