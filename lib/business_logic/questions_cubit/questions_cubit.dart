import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/business_logic/questions_cubit/questions_states.dart';
import '/peresentation/models/eve_model.dart';
import '/peresentation/models/question_model.dart';
import '/peresentation/models/say_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';

class QuestionsCubit extends Cubit<QuestionsStates> {
  QuestionsCubit() : super(QuestionInitial());

  List<QuestionModel> questions = [];

  Future<void> getQuestions() async {
    emit(GetQuestionsLoading());
    try {
      http.Response res =
          await http.get(Uri.parse(ApiConstants.getQuestionsEndPoint),
              headers:
              {"Accept-Language": "$loc"}
          );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          //
          // List<MovieModel>.from((response.data["results"] as List).map(
          //      (e) => MovieModel.fromJson(e),
          // ));
          questions = List<QuestionModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => QuestionModel.fromJson(e)));

          print(questions[0].titleEnglish);

          emit(GetQuestionsSuccess());
        } else {
          emit(GetQuestionsFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(GetQuestionsFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(GetQuestionsNoInternet(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetQuestionsFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  List<SayModel> whatSay = [];

  Future<void> getWhatSay() async {
    emit(GetWhatSayLoading());
    try {
      http.Response res =
          await http.get(Uri.parse(ApiConstants.getWhatSayEndPoint),
              headers:
              {"Accept-Language": "$loc"}
          );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          //
          // List<MovieModel>.from((response.data["results"] as List).map(
          //      (e) => MovieModel.fromJson(e),
          // ));
          whatSay = List<SayModel>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => SayModel.fromJson(e)));

          print(questions[0].titleEnglish);

          emit(GetWhatSaySuccess());
        } else {
          emit(GetWhatSayFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(GetWhatSayFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(GetWhatSayNoInternet(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetWhatSayFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  List<EveModel>? eve;

  Future<void> getEveDetails() async {
    emit(GetEveLoading());
    try {
      http.Response res = await http.get(Uri.parse(ApiConstants.getEve),
          headers:
          {"Accept-Language": "$loc"}
      );

      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          //
          // List<MovieModel>.from((response.data["results"] as List).map(
          //      (e) => MovieModel.fromJson(e),
          // ));
          eve = List<EveModel>.from((jsonDecode(res.body)["data"][0] as List)
              .map((e) => EveModel.fromJson(e)));

          emit(GetEveSuccess());
        } else {
          emit(GetEveFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      } else {
        emit(GetEveFailure(message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(GetEveNoInternet(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetEveFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
