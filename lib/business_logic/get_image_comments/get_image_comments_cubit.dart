import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../peresentation/models/image_comments.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';
import '../auth_cubit/auth_cubit.dart';
part 'get_image_comments_state.dart';

class GetImageCommentsCubit extends Cubit<GetImageCommentsState> {
  GetImageCommentsCubit() : super(GetImageCommentsInitial());
  List<ImagesComment> imageCommentsData = [];

  Future<void> getComments({
    required String imageId,
  }) async {
    emit(GetImageCommentsLoading());
    try {
      http.Response res = await http.post(
          Uri.parse(
              '${ApiConstants.getImageCommentsEndPoint}access-token=$token'),
          body: {
            "image_id": imageId,
          },
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] != 1) {
          emit(GetImageCommentsFailure(
              message: jsonDecode(res.body)["data"][0]["message"]));
        } else {
          imageCommentsData = List<ImagesComment>.from(
              (jsonDecode(res.body)["data"][0]['comments'] as List)
                  .map((e) => ImagesComment.fromjson(e)));
          emit(GetImageCommentsLoaded());
        }
      } else {
        emit(GetImageCommentsFailure(message:tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(GetImageCommentsFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetImageCommentsFailure(message:tr(StringConstants.problemMessageInCubit)));
    }
  }
}
