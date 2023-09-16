import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/utilities/constants/api_constants.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../peresentation/models/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CardModel> cardList = [];
  List itemList = [];
  String ?totalPrice ;
  String ?count ;

  getCart() async {
    emit(LoadingCartState());
    try {
    http.Response res = await http.get(Uri.parse(
        '${ApiConstants.getCartCubit}access-token=$token'),
        headers:
        {"Accept-Language": "$loc"}
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)["status"] == 1) {
        itemList = jsonDecode(res.body)["data"]["requist"];
        print("==============================");
        // cardList = List<CardModel>.from(
        //     (jsonDecode(res.body)["data"]["requist"] as List).map((e) {
        //   return CardModel.fromJson(e);
        // }));
        totalPrice = jsonDecode(res.body)['data']['total']??"0";
        count = jsonDecode(res.body)["data"]["count"]??"0";
        debugPrint(count);
        emit(SuccessCartState());
      } else {
        emit(FailureCartState(message: jsonDecode(res.body)["data"]["message"]));
      }
    } else {
      emit(FailureCartState(message: tr(StringConstants.problemMessageInCubit)));
    }
    } on SocketException {
      emit(FailureCartState(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(FailureCartState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> delCartItem(String itemId) async {
    emit(LoadingDelCartState());
    try {
    http.Response res = await http.post(
        Uri.parse(
            '${ApiConstants.deleteCartCubit}?access-token=$token'),
        body: {"id": itemId},
        headers:
        {"Accept-Language": "$loc"}
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['data'][0]['status'] == "1") {
        emit(SuccessDelCartState(
            message: jsonDecode(res.body)['data'][0]['message']));
      } else {
        emit(FailureDelCartState(
            message: jsonDecode(res.body)['data'][0]['message']));
      }
    } else {
      emit(FailureDelCartState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }on  SocketException {
      emit(FailureDelCartState(message: tr(StringConstants.noInternet)));

    } catch(e) {
      debugPrint(e.toString());
      emit(FailureDelCartState(message: tr(StringConstants.problemMessageInCubit)));

    }
  }

  Future<void> orderDone() async {
    emit(LoadingOrderDoneState());
    try {
    http.Response res = await http.post(Uri.parse(
        '${ApiConstants.checkOutCartCubit}access-token=$token'),
        headers:
        {"Accept-Language": "$loc"}
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['data'][0]['status'] == "1") {
        emit(SuccessOrderDoneState(
            message: jsonDecode(res.body)['data'][0]['message']));
      } else {
        emit(FailureOrderDoneState(
            message: jsonDecode(res.body)['data'][0]['message']));
      }
    } else {
      emit(FailureOrderDoneState(message: tr(StringConstants.problemMessageInCubit)));
    }
      } on SocketException {
      emit(FailureOrderDoneState(message: tr(StringConstants.noInternet)));
    }
    catch (e) {
      emit(FailureOrderDoneState(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
