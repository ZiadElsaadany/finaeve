import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_cubit.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../utilities/constants/string_constants.dart';
part 'image_comments_state.dart';

class ImageCommentsCubit extends Cubit<ImageCommentsState> {
  ImageCommentsCubit() : super(PostImageCommentsInitial());
  Future<void> postComment({
    required String imageId,
    required String comment,
  }) async {
    emit(PostImageCommentsLoading());
    try {
    http.Response res = await http.post(
        Uri.parse(
            '${ApiConstants.imageCommentsEndPoint}access-token=$token'),
        body: {
          "album_image_id": imageId,
          "comment": comment,
        },
        headers:
        {"Accept-Language": "$loc"}
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)["data"][0]["status"] != "1") {
        emit(PostImageCommentsFailure(
            message: jsonDecode(res.body)["data"][0]["message"]));
      } else {
        emit(PostImageCommentsLoaded(
            message: jsonDecode(res.body)["data"][0]["message"]));
      }
    } else {
      emit(PostImageCommentsFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
    } on SocketException {
      emit(PostImageCommentsFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(PostImageCommentsFailure(message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
