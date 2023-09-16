import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

part 'print_price_state.dart';

class PrintPriceCubit extends Cubit<PrintPriceState> {
  PrintPriceCubit() : super(PrintPriceInitial());
  late int price;

  Future<void> getPrintPrice({
    required String id,
  }) async {
    emit(PrintPriceLoading());
    try {
      http.Response response =
          await http.get(Uri.parse("${ApiConstants.printPrice}?id=$id"),
              headers:
              {"Accept-Language": "$loc"}
          );
      price = jsonDecode(response.body)["data"];
      emit(PrintPriceLoaded());
    } on SocketException {
      emit(PrintPriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(PrintPriceFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
