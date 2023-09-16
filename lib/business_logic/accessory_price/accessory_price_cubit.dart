import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';
part 'accessory_price_state.dart';

class AccessoryPriceCubit extends Cubit<AccessoryPriceState> {
  AccessoryPriceCubit() : super(AccessoryPriceInitial());
  late int price;
  Future<void> getBoardPrice({
    required String id,
  }) async {
    emit(AccessoryPriceLoading());
    try {
      http.Response response =
          await http.get(Uri.parse("${ApiConstants.accessoryPrice}?id=$id"),
              headers:
              {"Accept-Language": "$loc"}
          );
      price = jsonDecode(response.body)["data"];
      emit(AccessoryPriceLoaded());
    }  on SocketException {
      emit(AccessoryPriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(AccessoryPriceFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
