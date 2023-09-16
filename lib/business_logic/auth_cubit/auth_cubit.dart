import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/business_logic/auth_cubit/auth_states.dart';
import '/peresentation/models/login_model.dart';
import '/utilities/constants/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/constants/string_constants.dart';

String? token;
String? notificationToken;
String? userNamee;
int? userId;
String? name;
String? avatar;
String? email;
String? mobile;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialAuth());

  bool oldPassVisible = false;
  bool newPassVisible = false;
  bool confirmPassVisible = false;


 Future<void> removeShared( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userName');
    prefs.remove('name');
    prefs.remove('avatar');
    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('mobile');
    emit(RemoveSharedState(  ) );
  }
  changeOldPassVisible() {
    oldPassVisible = !oldPassVisible;
    emit(ChangeVisibleOldPass());
  }

  changeNewPassVisible() {
    newPassVisible = !newPassVisible;
    emit(ChangeVisibleNewPass());
  }

  changeConfirmPassVisible() {
    confirmPassVisible = !confirmPassVisible;
    emit(ChangeVisibleConfirmPass());
  }

  LoginModel? loginModel;

  Future<void> login(
      {required String userName, required String password}) async {
    emit(LoginLoading());
    try {
      http.Response res = await http.post(Uri.parse(ApiConstants.login),
          body: {"username": userName, "password": password},
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          loginModel =
              LoginModel.fromJson(jsonDecode(res.body)["data"][0]["data"]);
          final sharedPref = await SharedPreferences.getInstance();
          await sharedPref.setString(
              "token", jsonDecode(res.body)["data"][0]["access_token"]);
          await sharedPref.setString("userName", loginModel!.username);
          token = sharedPref.getString("token");

          userNamee = sharedPref.getString("userName");

          await sharedPref.setInt("userId", loginModel!.userId);
          userId = sharedPref.getInt("userId");
          await sharedPref.setString("mobile", loginModel!.mobile);
          mobile = sharedPref.getString("mobile");
          await sharedPref.setString("avatar", loginModel!.avatar);
          avatar = sharedPref.getString("avatar");
          await sharedPref.setString("email", loginModel!.email);
          email = sharedPref.getString("email");
          await sharedPref.setString("name", loginModel!.name);
          name = sharedPref.getString("name");

          if (token != null || userNamee != null) {
            emit(LoginSuccess(
              loginSuccess: jsonDecode(res.body)["data"][0]["message"],
            ));
          }
        } else {
          emit(LoginFailure(
              loginFailureMessage: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(LoginFailure(loginFailureMessage: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(LoginFailure(
          loginFailureMessage: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> updateLogin({required String password}) async {
    emit(LoginLoading());
    try {
      http.Response res = await http.post(Uri.parse(ApiConstants.resetPassword),
          body: {"token": token, "password": password},
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(UpdateLoginSuccess(
            loginSuccess: jsonDecode(res.body)["data"][0]["message"],
          ));
        } else {
          emit(UpdateLoginFailure(
              loginFailureMessage: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(UpdateLoginFailure(
          loginFailureMessage: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(UpdateLoginFailure(
          loginFailureMessage: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> forgetPassword({required String mobile}) async {
    emit(LoginLoading());
    try {
      http.Response res = await http.post(Uri.parse(ApiConstants.passwordReset),
          body: {"mobile": mobile},
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(ForgetPasswordSuccess(
            loginSuccess: jsonDecode(res.body)["data"][0]["message"],
          ));
        } else {
          emit(ForgetPasswordLoginFailure(
              loginFailureMessage: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(ForgetPasswordLoginFailure(
          loginFailureMessage: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(ForgetPasswordLoginFailure(
          loginFailureMessage: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> updatePassword({
    required String password,
    required String newPasswordConfirm,
  }) async {
    emit(UpdatePasswordLoading());
    try {
      http.Response res = await http.post(
          Uri.parse("${ApiConstants.updateProfile}?access-token=$token"),
          body: {
            "password": password,
            "newPasswordConfirm": newPasswordConfirm
          },
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(UpdatePasswordSuccess(
            passSuccess: jsonDecode(res.body)["data"][0]["message"],
          ));
        } else {
          emit(UpdatePasswordFailure(
              passFailure: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(UpdatePasswordFailure(passFailure: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(UpdatePasswordFailure(
          passFailure: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> updateProfile(
      {required String name, required String mobile, File? file}) async {
    emit(UpdateProfileLoading());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ApiConstants.updateProfile}?access-token=$token"),
      );
      request.fields['name'] = name;
      request.fields['mobile'] = mobile;

      if (file != null) {
        var fileStream2 = http.ByteStream(Stream.castFrom(file.openRead()));
        var length2 = await file.length();
        var multipartFile2 = http.MultipartFile('file', fileStream2, length2,
            filename: file.path);
        request.files.add(multipartFile2);
      }
      request.headers.addAll({"Accept-Language": "$loc"});

      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(await response.stream.bytesToString());

        if (responseJson["status"] == 1) {
          SharedPreferences shared = await SharedPreferences.getInstance();
          await shared.setString(
              "avatar", responseJson["data"][0]["model"]["avatar"]);
          await shared.setString(
              "userName", responseJson["data"][0]["model"]["username"]);
          await shared.setString(
              "mobile", responseJson["data"][0]["model"]["mobile"]);
          await shared.setString(
              "name", responseJson["data"][0]["model"]["name"]);
          await shared.setInt(
              "userId", responseJson["data"][0]["model"]["user_id"]);
        }
        emit(UpdateProfileSuccess(
            loginSuccess: responseJson["data"][0]["message"]));
      } else {
        emit(UpdateProfileFailure(
            loginFailureMessage:
                jsonDecode(await response.stream.bytesToString())["data"][0]
                    ["message"]));
      }
    } on SocketException {
      emit(UpdateProfileFailure(
          loginFailureMessage: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(UpdateProfileFailure(
          loginFailureMessage: tr(StringConstants.problemMessageInCubit)));
    }
    //
    // Future<void> updateProfile (
    //     {
    //       required String name,
    //       required String mobile,
    //     }
    //     ) async  {
    //   emit(LoginLoading());
    //   try {
    //     http.Response res  =await http.post(Uri.parse(ApiConstants.updateProfile),
    //         body:  {
    //           "mobile":mobile,
    //           "name":name
    //         }
    //     );
    //     if(res.statusCode == 200 )  {
    //       if(jsonDecode(res.body)["status"] == 1 )  {
    //
    //           emit(UpdateProfileSuccess(
    //             loginSuccess: jsonDecode(res.body)["data"][0]["message"],
    //           ));
    //
    //       }else {
    //         emit(UpdateProfileFailure(
    //             loginFailureMessage: jsonDecode(res.body)["data"][0]["message"]
    //         ));
    //
    //       }
    //
    //     }
    //   }on SocketException{
    //     emit(UpdateProfileFailure(loginFailureMessage: "No Internet"));
    //
    //   }
    //   catch(e) {
    //     print(e.toString());
    //     emit(UpdateProfileFailure(loginFailureMessage: 'Problem Went Wrong'));
    //
    //   }
    //
    // }
  }

  File? userImgFile;

  getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      userImgFile = File(pickedImage.path);

      emit(GetImageFromGallery());
    }
  }

  Future<void> activate({
    required String email,
    required String activation_code,
  }) async {
    emit(ActivateLoading());
    try {
      http.Response res = await http.post(Uri.parse(ApiConstants.activate),
          body: {"email": email, "activation_code": activation_code});
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          emit(ActivateSuccess(
            activateSuccess: jsonDecode(res.body)["data"][0]["message"],
          ));
        } else {
          emit(ActivateFailure(
              activateFailure: jsonDecode(res.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(ActivateFailure(activateFailure: tr(StringConstants.noInternet)));
    } catch (e) {
      print(e.toString());
      emit(ActivateFailure(
          activateFailure: tr(StringConstants.problemMessageInCubit)));
    }
  }

// Define the endpoint URL

// Define the request body

// Make the POST request
  Future<void> deviceToken({
    required String deviceToken,
    required String device_type,
  }) async {
    emit(DeviseTokenStateLoading());

    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.deviceTokenEndPoint}access-token=$token"),
        body: {'device_token': deviceToken, 'device_type': device_type},
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response
        if (jsonDecode(response.body)["status"] == 1) {
          print("************************************************************");
          print(deviceToken);
          print("************************************************************");
          print(device_type);
          emit(DeviseTokenStateSuccess(
              message: jsonDecode(response.body)["data"][0]["message"]));
        } else {
          emit(DeviseTokenStateFailure(
              message: tr(StringConstants.problemMessageInCubit)));
        }
        // Process the response data here
      } else {
        // Request failed, handle the error
        emit(DeviseTokenStateFailure(
            message: tr(StringConstants.problemMessageInCubit)));
      }
    } on SocketException {
      emit(DeviseTokenStateFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      // An error occurred, handle the exception
      emit(DeviseTokenStateFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }
}
