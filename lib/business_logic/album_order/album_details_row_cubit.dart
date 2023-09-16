import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/string_constants.dart';
import '../auth_cubit/auth_cubit.dart';

part 'album_details_row_state.dart';

class AlbumDetailsRowCubit extends Cubit<AlbumDetailsRowState> {
  AlbumDetailsRowCubit() : super(AlbumDetailsRowInitial());

  int indexOfSelectedRequestOfAlbum = 0;

  void changeIndexOfSelectedRequestOfAlbum(
      {required int indexOfSelectedRequestOfAlbum}) {
    this.indexOfSelectedRequestOfAlbum = indexOfSelectedRequestOfAlbum;
    print("indexOfSelectedRequestOfAlbum" +
        indexOfSelectedRequestOfAlbum.toString());
    emit(ChangeIndexOfRequestAlbumState());
  }

  void restartIndexOfSelectedRequestOfAlbum() {
    indexOfSelectedRequestOfAlbum = 0;
    emit(RestartIndexOfRequestAlbumState());
  }

  void minusIndexOfSelectedRequestOfAlbum() {
    if (indexOfAlbumPrint >= 0) {
      indexOfAlbumPrint--;
    }
    // 0
    // 1
    //2
    //3
    //4

    emit(MinusIndexOfRequestAlbumState());
  }

//Album Print logic
  int indexOfAlbumPrint = 0;

  void changeIndexOfAlbumPrint({required int indexOfAlbumPrint}) {
    this.indexOfAlbumPrint = indexOfAlbumPrint;
    emit(ChangeIndexOfAlbumPrintState());
  }

  void plusIndexOfAlbumPrint() {
    if (indexOfAlbumPrint < 3) {
      indexOfAlbumPrint++;
    }
    emit(PlusIndexOfAlbumPrintState());
  }

  void restartAlbumPrintState() {
    indexOfAlbumPrint = 0;
    emit(RestartAlbumPrintState());
  }

  //Album without print logic
  int indexOfAlbumWithoutCircleAvatarPrint = 0;

  void setIndexOfCircleAvatarInAlbumWithoutPrint(
      {required int indexOfCircleAvatar}) {
    indexOfAlbumWithoutCircleAvatarPrint = indexOfCircleAvatar;
    emit(SetIndexOfCircleAvatarInAlbumWithoutPrint());
  }

  void restartIndexOfAlbumWithoutCircleAvatarPrint() {
    indexOfAlbumWithoutCircleAvatarPrint = 0;
    emit(RestartIndexOfAlbumWithoutCircleAvatarPrintState());
  }

  void plusIndexOfCircleAvatarInAlbumWithoutPrint() {
    if (indexOfAlbumWithoutCircleAvatarPrint < 2) {
      indexOfAlbumWithoutCircleAvatarPrint++;
    }
    emit(PlusIndexOfCircleAvatarInAlbumWithoutPrint());
  }
  void minusIndexOfRequestWithoutPrintAlbum() {
    if (indexOfAlbumWithoutCircleAvatarPrint >= 0) {
      indexOfAlbumWithoutCircleAvatarPrint--;
    }
    emit(MinusIndexOfRequestWithoutPrintAlbumState());
  }


  Future<void> sendAlbumRequestWithPrint(
      {required String album_type,
      required String size_id,
      required String box,
      required String with_extension,
      required String number_of_page,
      required String with_process,
      required String album_type_id,
      required String color_id,
      required String corner_id,
      required String with_open_flash,
      required String with_design,
      required String couple_name,
      required String drilling_type_id,
      required String with_date,
      required String side_image,
      required String image_type,
      required String paper_type_id,
      required String description,
      required String album_price,
      required String model_image,
      required File? album_model,
      required String extension_type_id,
      required String processing_note,
      required String other_color,
      required String date,
      required String side_image_size,
      required String ?number,
      required String url,
      required String cover_type_id,
      required File? image,
      required BuildContext context}) async {
    emit(SendRequestLoadingStates());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiConstants.sentAlbumReqEndPoint}access-token=$token",),
      );
      request.fields['album_type'] = album_type;
      request.fields['size_id'] = size_id;
      request.fields['box'] = box;
      request.fields['with_extension'] = with_extension;
      request.fields['number_of_page'] = number_of_page;
      request.fields['with_process'] = with_process;
      request.fields['album_type_id'] = album_type_id;
      request.fields['color_id'] = color_id;
      request.fields['corner_id'] = corner_id;
      request.fields['with_open_flash'] = with_open_flash;
      request.fields['couple_name'] = couple_name;
      request.fields['drilling_type_id'] = drilling_type_id;
      request.fields['with_date'] = with_date;
      request.fields['side_image'] = side_image;
      request.fields['image_type'] = image_type;
      request.fields['paper_type_id'] = paper_type_id;
      request.fields['description'] = description;
      request.fields['album_price'] = album_price;
      request.fields['model_image'] = model_image;
      request.fields['extension_type_id'] = extension_type_id;
      request.fields['processing_note'] = processing_note;
      request.fields['other_color'] = other_color;
      request.fields['date'] = date;
      request.fields['side_image_size'] = side_image_size;
      request.fields['number'] = number??"";
      request.fields['url'] = url;
      request.fields['with_design'] = with_design;
      request.fields['cover_type_id'] = cover_type_id;
      request.headers.addAll({"Accept-Language": "$loc"});
      if (album_model != null) {


        var fileStream =
            http.ByteStream(Stream.castFrom(album_model.openRead()));
        var length = await album_model.length();
        var multipartFile = http.MultipartFile(
            'album_model', fileStream, length,
            filename: album_model.path);
        request.files.add(multipartFile);
      }
      if (image != null) {
        var fileStream2 = http.ByteStream(Stream.castFrom(image.openRead()));
        var length2 = await image.length();
        var multipartFile2 = http.MultipartFile('image', fileStream2, length2,
            filename: image.path);
        request.files.add(multipartFile2);
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(await response.stream.bytesToString());
        debugPrint("extension_type_id"+extension_type_id);

        if (responseJson["status"] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(responseJson["data"][0]["message"])));
          emit(SendRequestSuccessStates(
              message: responseJson["data"][0]["message"]));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(responseJson["data"][0]["message"])));

          emit(SendRequestFailureStates(
              message: responseJson["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(SendRequestFailureStates(message: tr(StringConstants.noInternet)));
    }
    catch (e) {
      print(e.toString());
      emit(SendRequestFailureStates(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }


  Future<void> sendAlbumRequestWithoutPrint(
      {required String album_type,
        required String size_id,
        required String box,
        required String with_extension,
        required String album_type_id,
        required String color_id,
        required String corner_id,
        required String with_open_flash,
        required String couple_name,
        required String drilling_type_id,
        required String extension_type_id,
        required String with_date,
        required String description,
        required String album_price,
        required String model_image,
        required File? album_model,
        required String other_color,
        required String date,
        required String cover_type_id,
        required BuildContext context}) async {
    emit(SendRequestLoadingWithoutAlbumStates());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("https://www.eve-albums.com/api/web/v1/site/create2?access-token=$token"),
      );
      request.fields['album_type'] = album_type;
      request.fields['size_id'] = size_id;
      request.fields['box'] = box;

      request.fields['album_type_id'] = album_type_id;
      request.fields['color_id'] = color_id;
      request.fields['corner_id'] = corner_id;
      request.fields['with_open_flash'] = with_open_flash;
      request.fields['couple_name'] = couple_name;
      request.fields['drilling_type_id'] = drilling_type_id;
      request.fields['with_date'] = with_date;

      request.fields['description'] = description;
      request.fields['album_price'] = album_price;
      request.fields['model_image'] = model_image;

      request.fields['other_color'] = other_color;
      request.fields['date'] = date;
      request.fields['with_extension'] = with_extension;
      request.fields['cover_type_id'] = cover_type_id;
      request.fields['extension_type_id'] = extension_type_id;

      request.headers.addAll({"Accept-Language": "$loc"});

      if (album_model != null) {


        var fileStream =
        http.ByteStream(Stream.castFrom(album_model.openRead()));
        var length = await album_model.length();
        var multipartFile = http.MultipartFile(
            'album_model', fileStream, length,
            filename: album_model.path);
        request.files.add(multipartFile);
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(await response.stream.bytesToString());

        if (responseJson["status"] == 1) {
          debugPrint("extension_type_id"+extension_type_id);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(responseJson["data"][0]["message"])));
          emit(SendRequestSuccessWithoutAlbumStates(
              message: responseJson["data"][0]["message"]));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(responseJson["data"][0]["message"])));

          emit(SendRequestFailureWithoutAlbumStates(
              message: responseJson["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(SendRequestFailureWithoutAlbumStates(message: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(SendRequestFailureWithoutAlbumStates(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }



  sendRequestForPrintWithFillerScreen(
      {required String album_type,
      required String size_id,
      required String number_of_page,
      required String with_process,
      required String image_type,
      required String paper_type_id,
      required String description,
      required String album_price,
      required String processing_note,
      required String url,
      required String with_design,
      required File? image,
      required BuildContext context}) async {
    emit(SendRequestForPrintWithFillerLoadingStates());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "${ApiConstants.sendRequestForPrintWithFillerScreenEndPoint}access-token=$token"),
      );
      request.fields['album_type'] = album_type;
      request.fields['size_id'] = size_id;
      request.fields['number_of_page'] = number_of_page;
      request.fields['with_process'] = with_process;

      request.fields['image_type'] = image_type;
      request.fields['paper_type_id'] = paper_type_id;
      request.fields['description'] = description;
      request.fields['album_price'] = album_price;
      request.fields['with_design'] = with_design;

      request.fields['processing_note'] = processing_note;

      request.fields['url'] = url;
      request.headers.addAll({"Accept-Language": "$loc"});


      if (image != null) {
        var fileStream2 = http.ByteStream(Stream.castFrom(image.openRead()));
        var length2 = await image.length();
        var multipartFile2 = http.MultipartFile('image', fileStream2, length2,
            filename: image.path);
        request.files.add(multipartFile2);
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(await response.stream.bytesToString());

        if (responseJson["status"] == 1) {
          emit(SendRequestForPrintWithFillerSuccessStates(
              message: responseJson["data"][0]["message"]));
        } else {


          emit(SendRequestForPrintWithFillerFailureStates(
              message: responseJson["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(SendRequestForPrintWithFillerFailureStates(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(SendRequestForPrintWithFillerFailureStates(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }



  Future<void> sendRequestForAccessories(
      {required String album_type,
        required String accessories_type,
        required String description,
        required String album_price,
        required String accessories_type_board,
        required String accessories_type_print,
        required String couple_name,
        required String drilling_type_id,
        required String with_date,
        required String date,
        required String color_id,
        required String other_color,
        required BuildContext context}) async {
    print("start");
    emit(SendRequestForPrintWithLoadingAccessories());
    try {
      http.Response  res  = await http.post(Uri.parse("https://www.eve-albums.com/api/web/v1/site/create4?access-token=$token"),
      body:  {
        "album_type" : album_type,
        "accessories_type" : accessories_type,
        "description" : description.toString(),
        "album_price" : album_price,
        "accessories_type_board" : accessories_type_board,
        "accessories_type_print" : accessories_type_print,
        "couple_name" : couple_name,
        "drilling_type_id" : drilling_type_id,
        "with_date" : with_date,
        "date" : date,
        "other_color" : other_color,
        "color_id" : color_id,
      },


          headers:
          {"Accept-Language": "$loc"}

      );

      if(res.statusCode == 200 ) {
        if(jsonDecode(res.body)["status"] == 1 ) {
          emit(SendRequestForSuccessAccessoriesStates(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }   else {
          emit(SendRequestForFailureAccessoriesStates(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    else {
    emit(SendRequestForFailureAccessoriesStates(
    message: tr(StringConstants.problemMessageInCubit) )) ;
    }

    }on SocketException {
      emit(SendRequestForFailureAccessoriesStates(
          message: tr(StringConstants.noInternet) )) ;
    }  catch(e) {
      emit(SendRequestForFailureAccessoriesStates(
          message: tr(StringConstants.problemMessageInCubit) )) ;
    }
    }

    Future<void> sendRequestForMagazine(
      {required String album_type,
        required String accessories_type,
        required String description,
        required String album_price,
        required String accessories_type_board,
        required String accessories_type_print,
        required String couple_name,
        required String drilling_type_id,
        required String with_date,
        required String date,
        required String color_id,
        required String other_color,
        required BuildContext context}) async {
    print("start");
    emit(SendRequestForPrintWithLoadingMagazine());
    try {
      http.Response  res  = await http.post(Uri.parse("https://www.eve-albums.com/api/web/v1/site/create6?access-token=$token"),
      body:  {
        "album_type" : album_type,
        "accessories_type" : accessories_type,
        "description" : description.toString(),
        "album_price" : album_price,
        "accessories_type_board" : accessories_type_board,
        "accessories_type_print" : accessories_type_print,
        "couple_name" : couple_name,
        "drilling_type_id" : drilling_type_id,
        "with_date" : with_date,
        "date" : date,
        "other_color" : other_color,
        "color_id" : color_id,
      },
          headers:
          {"Accept-Language": "$loc"}

      );

      if(res.statusCode == 200 ) {
        if(jsonDecode(res.body)["status"] == 1 ) {
          emit(SendRequestForSuccessMagazineStates(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }   else {
          emit(SendRequestForFailureMagazineStates(
              message: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    else {
    emit(SendRequestForFailureMagazineStates(
    message: tr(StringConstants.problemMessageInCubit) )) ;
    }

    }on SocketException {
      emit(SendRequestForFailureMagazineStates(
          message: tr(StringConstants.noInternet) )) ;
    }  catch(e) {
      emit(SendRequestForFailureMagazineStates(
          message: tr(StringConstants.problemMessageInCubit) )) ;
    }
    }




  sendRequestForPrintWithPaint(
      {required String album_type,

        required String description,

        required String url,
        required File? image,
        required BuildContext context}) async {
    emit(SendRequestForPrintWithPaintLoadingStates());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://www.eve-albums.com/api/web/v1/site/create5?access-token=$token"),
      );
      request.fields['album_type'] = album_type;

      request.fields['description'] = description;


      request.fields['url'] = url;

      if (image != null) {
        var fileStream2 = http.ByteStream(Stream.castFrom(image.openRead()));
        var length2 = await image.length();
        var multipartFile2 = http.MultipartFile('image', fileStream2, length2,
            filename: image.path);
        request.files.add(multipartFile2);
      }
      request.headers.addAll({"Accept-Language": "$loc"});

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(await response.stream.bytesToString());

        if (responseJson["status"] == 1) {
          emit(SendRequestForPrintWithPaintSuccessStates(
              message: responseJson["data"][0]["message"]));
        } else {


          emit(SendRequestForPrintWithPaintFailureStates(
              message: responseJson["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(SendRequestForPrintWithPaintFailureStates(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(SendRequestForPrintWithPaintFailureStates(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

}
