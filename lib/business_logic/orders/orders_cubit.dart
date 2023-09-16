import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  Future<void> addAccessoriesOrder(
      {required String token,
      required String accessoriesType,
      required int price}) async {
    try {
      http.Response res = await http.post(
          Uri.parse("${ApiConstants.orderAccessories}?access-token=$token"),
          body: {
            "album_type": "4",
            "accessories_type": accessoriesType,
            "album_price": price,
          },headers:
      {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(res.body);
        if (responseJson['status'] != 1) {
          throw Exception("Error in the Status of the Response");
        }
        emit(OrdersAddOrderSuccessState());
      } else {
        emit(OrdersAddOrderErrorState(
            message: "${res.statusCode} Status Code Error"));
      }
    } on SocketException {
      emit(OrdersAddOrderNoInternetState(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(OrdersAddOrderErrorState(message: tr(StringConstants.noInternet)));
    }
  }

  Future<void> addDrawingOrder(
      {required String token,
      required File? image,
      required String url}) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiConstants.orderDrawing}?access-token=$token"),
      );

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });
      request.headers.addAll({"Accept-Language": "$loc"});

      request.fields['album_type'] = "5";
      request.fields['url'] = url;
      request.files.add(
        image == null
            ? http.MultipartFile.fromBytes('image', <int>[])
            : await http.MultipartFile.fromPath('image', image.path),
      );

      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseDecoded =
            jsonDecode(await response.stream.bytesToString());
        if (responseDecoded['status'] != 1) {
          throw Exception("Error in the Status of the Response");
        }
        emit(OrdersAddOrderSuccessState());
      } else {
        emit(OrdersAddOrderErrorState(
            message: "${response.statusCode} Status Code Error"));
      }
    } on SocketException {
      emit(OrdersAddOrderNoInternetState(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(OrdersAddOrderErrorState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  /// TODO : Need to know more about parameters

}
