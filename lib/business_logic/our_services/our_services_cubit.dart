import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/peresentation/models/our_services.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';
part 'our_services_state.dart';

class OurServicesCubit extends Cubit<OurServicesState> {
  OurServicesCubit() : super(OurServicesInitial());
  List<OurServicesModel> ourServices=[];
  
  getOurServices() async{
    emit(LoadingStateOurServices());

    try{
      http.Response res= await http.get(Uri.parse(ApiConstants.getOurServices),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          ourServices = List<OurServicesModel>.from(
              (jsonDecode(res.body)["data"][0] as List).map((e) {
                return OurServicesModel.fromJson(e);
              }));
          emit(SuccessStateOurServices());
        } else {
          emit(ErrorStateOurServices(tr(StringConstants.problemMessageInCubit)));
        }
      }else {
        emit(ErrorStateOurServices( tr(StringConstants.problemMessageInCubit)));
      }
    }on SocketException {
      emit(ErrorStateOurServices( tr(StringConstants.noInternet)));
    } catch (e) {
      emit(ErrorStateOurServices(tr(StringConstants.problemMessageInCubit)));
    }
  }
  
}
