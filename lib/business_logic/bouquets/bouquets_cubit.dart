import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/peresentation/models/bouquets_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

part 'bouquets_state.dart';

class BouquetsCubit extends Cubit<BouquetsState> {
  BouquetsCubit() : super(BouquetsInitial());
  List<BouquetsModel> bouquets = [];
  int currentPage = 1;
   int numberOfPages=1;

  Future<void> getBouquetsInformation() async {
    emit(LoadingBouquets());
    try {
      http.Response res = await http
          .get(Uri.parse(ApiConstants.getBoquets),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          currentPage = jsonDecode(res.body)["data"][0]["_meta"]["currentPage"];
          numberOfPages =
          (jsonDecode(res.body)["data"][0]["_meta"]["NumberOfPage"]);
          bouquets += List<BouquetsModel>.from(
              (jsonDecode(res.body)["data"][0]["items"] as List).map((e) {
            return BouquetsModel.fromJson(e);
          }));
          emit(BouquetsLoaded(bouquets: bouquets));
          emit(SuccessBouquets());
        } else {
          emit(FailureBouquets(message: tr(StringConstants.problemMessageInCubit)));
        }
      }else {
        emit(FailureBouquets(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(FailureBouquets(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureBouquets(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
