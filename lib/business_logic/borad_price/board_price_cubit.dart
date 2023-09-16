import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';
part 'board_price_state.dart';

class BoardPriceCubit extends Cubit<BoardPriceState> {
  BoardPriceCubit() : super(BoardPriceInitial());
  late int price;
  Future<void> getBoardPrice({
    required String id,
  }) async {
    emit(BoardPriceLoading());
    try {
      http.Response response =
          await http.get(Uri.parse("${ApiConstants.boardPrice}?id=$id"),
              headers:
              {"Accept-Language": "$loc"}
          );
      price = jsonDecode(response.body)["data"];
      emit(BoardPriceLoaded());
    } on SocketException {
      emit(BoardPriceFailure(message: tr(StringConstants.noInternet)));
    }catch (e) {
      emit(BoardPriceFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
