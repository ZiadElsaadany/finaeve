import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import '/peresentation/models/list_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../utilities/constants/api_constants.dart';
import '../../utilities/constants/string_constants.dart';
import '../album_order/album_details_row_cubit.dart';
import '../auth_cubit/auth_cubit.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(ListsInitial());
  ListResponseModel? dataAllMenues;
  AlbumSize? currentSize;
  BaseIdNameModel? boxYesOrNo;
  BaseIdNameModel? withEditOrNot;
  BaseIdNameModel? withPageDesigner;
  Extension? extension;
  BaseIdNameModel? withExtensionOrNot;
  Album? albumTypeList;
  BaseIdNameModel? pages;

  DrillingType? drillingType;

  ColorResp? colorResp;
  BaseIdNameModel? showDateForSend;
  BaseIdNameModel? photoForFamily;
  BaseIdNameModel? with_or_without_accessories;
  SideImageSize? sideImageSize;
  BaseIdNameModel? imageType;
  BaseIdNameModel? accessoriesType;
  PaperType? paperType;
  BoardSize? boardSizeAcceso;
  PrintSize? printSize;
  ModelImage? modelImage;

  // color here
  Corner? corner;

  BaseIdNameModel? withUsb;

  // void changeCurrentSize(String name) {
  //   currentSize = dataAllMenues!.albumSizes!.firstWhere(
  //           (element) => element.name == name || element.nameEng == name);
  //   debugPrint(currentSize?.id.toString());
  //   emit(ChangeCurrentSizeState());
  // }

  void changeEditOrNot(String name) {
    withEditOrNot = dataAllMenues!.yesOrNoOptions!
        .firstWhere((element) => element.name == name);
    emit(ChangeOptionsState());
  }

  void changeboardSizeAcceso(String name) {
    boardSizeAcceso =lstBoardSize!
        .firstWhere((element) => element.name == name);
    emit(ChangeboardSizeAccesoState());
  }

  void changeWithExtensionWithNot(String name) {
    withExtensionOrNot = dataAllMenues!.yesOrNoOptions!
        .firstWhere((element) => element.name == name);
    emit(ChangeOptionsState());
  }



  void changeAccessoriesType(String name) {
    accessoriesTypeForFiller = lstOfAccessoriesTypeForFiller!
        .firstWhere((element) => element.name == name);

    emit(ChangeAccessoriesTypecState());
  }

  void makeChangeImageModelEqualNull() {
    modelImage = null;
    emit(MakeChangeImageModelEqualNullState());
  }

  void changeExtensions(String name) {
    extension = dataAllMenues!.extensions!
        .firstWhere((element) => element.name == name);
    emit(ChangeExtensionState());
  }

  void changePages(String name) {
    pages = dataAllMenues!.pages!.firstWhere((element) => element.name == name);
    emit(ChangePagesState());
  }

  void changePagesDesigner(String name) {
    withPageDesigner = dataAllMenues!.yesOrNoOptions!
        .firstWhere((element) => element.name == name);
    emit(ChangePagesDesignerState());
  }

  void changePrintSize(String name) {
    printSize = lstPrintSize!
        .firstWhere((element) => element.name == name);
    emit(ChangePrintSizeState());
  }

  // void changeAlbumDesigner(String name) {
  //   albumTypeList = dataAllMenues!.albumTypes!
  //       .firstWhere((element) => element.name == name);
  //   emit(ChangePagesDesignerState());
  // }



  void changeImageTypes(String name) {
    imageType = dataAllMenues!.imageTypes!
        .firstWhere((element) => element.name == name);
    emit(ImageTypesState());
  }

  void changePaperTypes(String name) {
    paperType = dataAllMenues!.paperTypes!
        .firstWhere((element) => element.name == name);
    emit(PaperTypesState());
  }

  void changeModelImages(int id) {
    modelImage =
        dataAllMenues!.modelImages!.firstWhere((element) => element.id == id);
    emit(ModelImagesState());
  }

  Future<void> getListsData(context) async {
    emit(ListsLoading());

    try {
      http.Response res = await http.get(Uri.parse(ApiConstants.lists),

          headers:
          {"Accept-Language": "$loc"}

      );
      if (res.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(res.body);
        debugPrint(responseJson.toString());
        if (responseJson['status'] != 1) {
          throw Exception("Error in the Status of the Response");
        }
        dataAllMenues = ListResponseModel.fromJson(responseJson["data"]);
        // withAlbumPrint
        getAlbumSizeForWithPrint();
        getBoxOrNotForWithPrint();
        getExtensionOrNotForWithPrint();
        getListExtensionsForAlbumWithPrint(); // ميني
        getModelImageWithPrint(); // images for box w
        getPagesForAlbumWithPrint();
        getProcessOrNotForAlbumWithPrintPrint();
        getDesignOrNotForAlbumWithPrintPrint();
        getAlbumMaterialTypeForWithPrint();
        getCoverTypeForWithPrint();
        getColorForAlbumWithPrint();
        getCornerForAlbumWithPrint();
        getWithUsbForAlbumWithPrint();
        getDrillingTypeForAlbumWithPrint();
        getHistoryOfAlbumWithPrint();
        getWithFamilyAlbumWithPrint();
        historyDateForAlbumWithPrint = "";
        numOfPhotosForAlbumWithPrint = "";
        getSideImageForAlbumWithPrint();
        getWayToUploadPhotoWithPrint();
        urlForAlbumWithPrint = '';
        selectedFileFprAlbumWithPrint=null;
         uploadAnotherModelOfPHOTOForAlbumWithPrint =null;
        getPaperTypeForAlbumWithPrint();
        albumPriceForAlbumWithPrint = 0;
        removeUploadAnotherModelOfPHOTOForAlbumWithPrint();
        descriptionForAlbumWithPrint = "";
        descriptionForAlbumWithoutPrint = "";
        miniForAlbumWithoutPrint= "";
        miniForAlbumWithPrint="";
        modelImageForWithoutPrint = null;
        modelImageForWithPrint= null;
        selectedFileForFiller = null;
        descriptionForFiller ="";
        notesForDesignForFiller ="";
        anotherColorTextForAccessories= "";
        anotherColorTextForWithoutPrintAlbum ="";
        anotherColorTextForWithoutPrintAlbum="";
        lstBoolForWithoutAlbum = [
          false,
          false,
          false,
        ]    ;
        lstBoolForWithAlbum =   [
          false,
          false,
          false,
        ];

        uploadAnotherModelOfPHOTOForAlbumWithoutPrint =null;

descriptionForAccessories ="";
        nameOfCouplesForAlbumPrint =  "";
        nameOfCouplesForWithoutAlbumPrint =  "";
        nameOfCouplesForAccessories=  "";
        getAccessoriesType();
        getBoardSize() ;
        selectedFileForPaint = null ;
        getPrintSize() ;
        notesForDesignForAlbumWithPrint = "";
       notesForDesignForFiller = "";
       historyDateForAccessories="";
       historyDateForAlbumWithoutPrint= "";
        getPainting();



        emit(ListsLoaded());
      } else {
        emit(ListsFailure("${res.statusCode} Status Code Error"));
      }
    } on SocketException {
      emit(ListsFailure(tr(StringConstants.noInternet)));
    } catch (e) {
      emit(ListsFailure(tr(StringConstants.problemMessageInCubit)));
    }
  }

  // restartRequestAlbum( ) {
  //   currentSize = dataAllMenues!.albumSizes![0];
  //   boxYesOrNo = dataAllMenues!.yesOrNoOptions![0];
  //   pages = dataAllMenues!.pages![0];
  //   extension= dataAllMenues!.extensions![0];
  //   withEditOrNot= dataAllMenues!.yesOrNoOptions![0];
  //   withPageDesigner= dataAllMenues!.yesOrNoOptions![0];
  //   //AlbumTypeList
  //   albumTypeList= dataAllMenues!.albumTypes![0];
  //   // color
  //   corner =  dataAllMenues!.corners![0];
  //   withUsb =  dataAllMenues!.yesOrNoOptions![0];
  //   drillingType = dataAllMenues!.drillingTypes![0];
  //   colorResp = dataAllMenues!.colorResponse![0];
  //   photoForFamily = dataAllMenues!.yesOrNoOptions![0];
  //   showDateForSend = dataAllMenues!.yesOrNoOptions![0];
  //   sideImageSize = dataAllMenues!.sideImageSizes![0];
  //   imageType = dataAllMenues!.imageTypes![0];
  //   paperType = dataAllMenues!.paperTypes![0];
  //   with_or_without_accessories =dataAllMenues!.yesOrNoOptions![0];
  //   modelImage =dataAllMenues!.modelImages![0];
  //   withExtensionOrNotTextFiled="";
  //   uploadAnotherModelOfPHOTO=null;
  //   historyDate="";
  //   anotherColorText="";
  //   nameOfCouples="";
  //   description="";
  //   numOfNumber=null;
  //   url="";
  //   result=null;
  //   selectedFile=null;
  //
  //
  //
  //
  //   emit(RestartProcessState());
  //
  // }

  File? uploadAnotherModelOfPHOTO;

  getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      uploadAnotherModelOfPHOTO = File(pickedImage.path);
      emit(GetImageFromGalleryState());
    }
  }

  removeUploadAnotherModelOfPHOTO() {
    uploadAnotherModelOfPHOTO = null;
    emit(RemoveUploadAnotherModelOfPHOTOState());
  }

  String withExtensionOrNotTextFiled = "";

  void setWithExtensionOrNotTextFiled(String txt) {
    withExtensionOrNotTextFiled = txt;
    emit(SetNotesStates());
  }

  String anotherColorText = "";

  void setAnotherColorText(String txt) {
    anotherColorText = txt;
    emit(SetAnotherColorText());
  }

  String? historyDate;

  void changeHistoryDate(String date) {
    historyDate = date;
    emit(ChangeHistoryDateState());
  }

  String? nameOfCouples;

  void changeCoupleNames(String couple) {
    nameOfCouples = couple;
    emit(ChangeCouplesState());
  }

  String descriptionForAccessories = "";

  void changeDescriptionForAccessories(String desc) {
    descriptionForAccessories = desc;
    emit(ChangeDescriptionForAccessoriesState());
  }

  String? numOfNumber;

  void changeNumberOfPhotos(String num) {
    numOfNumber = num;
    emit(ChangeNumOfPhotosState());
  }

  String url = "";

  void setUrl(String url) {
    this.url = url;
    emit(SetUrlState());
  }

  FilePickerResult? result;
  File? path;

  selectAndUploadFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip', 'rar'],
    );
    if (result != null) {
      path = File(result!.files.single.path!);
      // Upload the file or do something else with it.
    }
  }

  File? selectedFile;

  changeSelectedFile(file) {
    selectedFile = file;
    emit(ChangeSelectedFileState());
  }

  int albumPriceForAlbumWithPrint = 0;
  int albumPriceForAlbumWithoutPrint = 0;
  int albumPriceForFiller = 0;

  Future<void> getAlbumPrice(
      {required String id,
      required String page,
      required String box,
      required String type,
      required String orderType,
      required String drillingType,
      required String sideImage,
      required String withProcess,
      required String withExtension,
      required String withDesign,
      required String sideImagePage,
      required BuildContext context,
      required String modelImage}) async {

    emit(AlbumPriceLoading());
    albumPriceForAlbumWithPrint = 0;
    albumPriceForAlbumWithoutPrint = 0;
    albumPriceForFiller = 0;
    try {
      http.Response response = await http.get(Uri.parse(
          "${ApiConstants.getAlbumPriceEndPoint}id=$id&page=$page&box=$box&type=$type&order_type=$orderType&drilling_type=$drillingType&side_image=$sideImage&with_process=$withProcess&with_extension=$withExtension&with_design=$withDesign&side_image_page=$sideImagePage&model_image=$modelImage"
          // "https://webhook.site/5ed8620d-25a7-4921-9c09-25d55a522c9f?id=$id&page=$page&box=$box&type=$type&order_type=$orderType&drilling_type=$drillingType&side_image=$sideImage&with_process=$withProcess&with_extension=$withExtension&with_design=$withDesign&side_image_page=&model_image=$modelImage"
          ),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        print(          "${ApiConstants.getAlbumPriceEndPoint}id=$id&page=$page&box=$box&type=$type&order_type=$orderType&drilling_type=$drillingType&side_image=$sideImage&with_process=$withProcess&with_extension=$withExtension&with_design=$withDesign&side_image_page=$sideImagePage&model_image=$modelImage"
        );
        if (jsonDecode(response.body)["status"] == 1) {
          if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .indexOfSelectedRequestOfAlbum ==
              0) {
            albumPriceForAlbumWithPrint = jsonDecode(response.body)["data"];
          } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                  .indexOfSelectedRequestOfAlbum ==
              1) {
            albumPriceForAlbumWithoutPrint = jsonDecode(response.body)["data"];
          }else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
              .indexOfSelectedRequestOfAlbum ==
              2 ) {
            albumPriceForFiller =jsonDecode(response.body)["data"]   ;
          }
          emit(AlbumPriceLoaded());
        } else {
          emit(AlbumPriceFailure(
              message: jsonDecode(response.body)["data"]["message"]));
        }
      }
    } on SocketException {
      emit(AlbumPriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(AlbumPriceFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  restartPrice() {
    ///
    emit(RestartPriceState());
  }

  funGetPrice(context) {
    emit(InitialPrice());
    if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                .indexOfSelectedRequestOfAlbum +
            1 ==
        1) {
      BlocProvider.of<ListsCubit>(context).getAlbumPrice(
        context: context,
        id: currentSizeForPrintAlbum?.id.toString() ?? "",
        //
        page: pagesForAlbumWithPrint?.id ?? "",
        //
        box: boxYesOrNoAlbumWithPrint?.id ?? "",
        //
        type: albumMaterialTypeForAlbumWithPrint?.id.toString() ?? "",
        orderType: (BlocProvider.of<AlbumDetailsRowCubit>(context)
                    .indexOfSelectedRequestOfAlbum +
                1)
            .toString(),
        //
        drillingType: drillingTypeForAlbumWithPrint?.id.toString() ?? "",
        //
        sideImage: withFamilyAlbumWithPrint?.id=="1" ?sideImageForAlbumWithPrint?.id.toString() ?? "":"",
        withProcess: withProcessOrNotForAlbumWithPrint?.id ?? "",
        //
        withExtension: withExtensionOrNotForWithPrint?.id ?? "",
        withDesign: withProcessOrNotForAlbumWithPrint?.id=="0"?
        withDesignForAlbumWithPrint?.id ?? "":"",
        sideImagePage:
            withFamilyAlbumWithPrint?.id=="1" ?
        numOfPhotosForAlbumWithPrint:"",
        modelImage:
            boxYesOrNoAlbumWithPrint!.id == "1"
                ? modelImageForWithPrint?.id.toString() ?? ""
                : "",
      );
    }
    else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                .indexOfSelectedRequestOfAlbum +
            1 ==
        2) {
      // sideImagePage
      // page
      //with_process
      //

      BlocProvider.of<ListsCubit>(context).getAlbumPrice(
          context: context,
          id: currentSizeForWithoutPrintAlbum?.id.toString() ?? "",
          page: "",
          box: boxYesOrNoAlbumWithoutPrint?.id ?? "",
          type: albumMaterialTypeForAlbumWithoutPrint?.id.toString() ?? "",
          orderType: (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum +
                  1)
              .toString(),
          drillingType: drillingTypeForAlbumWithoutPrint?.id.toString() ?? "",
          sideImage: "",
          withProcess: "",
          withExtension: withExtensionOrNotForWithoutPrint?.id ?? "",
          withDesign:  "",
          sideImagePage: "",
          modelImage:boxYesOrNoAlbumWithoutPrint!.id == "1"
              ?  modelImageForWithoutPrint?.id.toString() ?? "": "",
      );
    } else if (BlocProvider.of<AlbumDetailsRowCubit>(context)
                .indexOfSelectedRequestOfAlbum +
            1 ==
        3) {
      // sideImagePage
      // page
      //with_process
      //

      BlocProvider.of<ListsCubit>(context).getAlbumPrice(
          context: context,
          id: currentSizeForFillerAlbum?.id.toString() ?? "",
          page: pagesForFiller?.id ?? "",
          box: "",
          type: "",
          orderType: (BlocProvider.of<AlbumDetailsRowCubit>(context)
                      .indexOfSelectedRequestOfAlbum +
                  1)
              .toString(),
          drillingType: "",
          sideImage: "",
          withProcess: withProcessOrNotForFiller?.id ?? "",
          withExtension: "",
          withDesign:withProcessOrNotForFiller?.id =="0"?  withDesignForFiller?.id ?? "": "",
          sideImagePage: "",
          modelImage: ""
      );
    }

    emit(GetpriceState());
  }

  Future<void> sendAccessoriesOrder({
    required String album_type,
    required String accessories_type,
    required String description,
    required String album_price,
    required String accessories_type_board,
    required String accessories_type_print,
    required String couple_name,
    required String drilling_type_id,
    required String with_date,
    required String date,
  }) async {
    emit(SendAccessoriesOrderLoading());
    try {
      http.Response response = await http.post(
          Uri.parse(
              "${ApiConstants.sentAccessoriesOrderEndPoint}access-token=$token"
              // "https://webhook.site/5ed8620d-25a7-4921-9c09-25d55a522c9f?id=$id&page=$page&box=$box&type=$type&order_type=$orderType&drilling_type=$drillingType&side_image=$sideImage&with_process=$withProcess&with_extension=$withExtension&with_design=$withDesign&side_image_page=&model_image=$modelImage"
              ),
          body: {
            "album_type": album_type,
            "accessories_type": accessories_type,
            "description": description,
            "album_price": album_price,
            "accessories_type_board": accessories_type_board,
            "accessories_type_print": accessories_type_print,
            "couple_name": couple_name,
            "drilling_type_id": drilling_type_id,
            "with_date": with_date,
            "date": date,
          },
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          emit(SendAccessoriesOrderLoaded(
              message: jsonDecode(response.body)["data"][0]["message"]));
        } else {
          emit(SendAccessoriesOrderFailure(
              message: jsonDecode(response.body)["data"][0]["message"]));
        }
      }
    } on SocketException {
      emit(
          SendAccessoriesOrderFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(SendAccessoriesOrderFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  // getgetBoardPrice

  int resultAcssPrice = 0;
  int boardPrice  = 0 ;

  Future<void> getBoardPrice({required String id}) async {
    emit(GetBoardPriceLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${ApiConstants.getBoardPriceEndPoint}id=$id"),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          boardPrice = jsonDecode(response.body)["data"];
          emit(GetBoardPriceLoaded());
        } else {
          boardPrice= 0;
          emit(GetBoardPriceFailure(
              message: jsonDecode(response.body)["data"]["message"]));
        }
      }else{
        emit(GetBoardPriceFailure(message: tr(StringConstants.noInternet)));

      }
    } on SocketException {
      emit(GetBoardPriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetBoardPriceFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> getPrintPrice({required String id}) async {
    emit(GetPrintPriceLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${ApiConstants.getPrintPrice}id=$id"),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          resultAcssPrice = jsonDecode(response.body)["data"];
          emit(GetPrintPriceLoaded());
        } else {
          emit(GetPrintPriceFailure(
              message: jsonDecode(response.body)["data"]["message"]));
        }
      }
    } on SocketException {
      emit(GetPrintPriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetPrintPriceFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  Future<void> getAccessoriesPrice({required String id}) async {
    emit(GetAccessoriePriceLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("${ApiConstants.getAccessoriesPrice}id=$id"),
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          resultAcssPrice = jsonDecode(response.body)["data"];
          emit(GetAccessoriePriceLoaded());
        } else {
          emit(GetAccessoriePriceFailure(
              message: jsonDecode(response.body)["data"]["message"]));
        }
      }
    } on SocketException {
      emit(GetAccessoriePriceFailure(message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetAccessoriePriceFailure(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }


  restartBoardScreen() {
    accessoriesType = dataAllMenues!.accessoriesTypes![0];
    boardSizeAcceso = dataAllMenues!.boardSizes![0];
    withPageDesigner = dataAllMenues!.yesOrNoOptions![0];
    emit(RestartBoard());
  }

  void getPriceToAccessories(context) {
    print(boardSizeAcceso?.id.toString()  );
    if (accessoriesTypeForFiller?.id == "1") {
      debugPrint("board price is "+boardPrice.toString());
      getBoardPrice(id: boardSizeAcceso?.id.toString() ?? "");
    }
    if (accessoriesTypeForFiller?.id == "2") {
      getPrintPrice(id: printSize?.id.toString() ?? "");
    } else {
      getAccessoriesPrice(id: accessoriesTypeForFiller?.id ?? "");
    }

    emit(GetPriceToAccessoriesState());
  }

  Future<void> getPaint({
    required String album_type,
    required String url,
    required String image,
    required String description,
  }) async {
    emit(SendPaintLoading());
    try {
      http.Response response = await http.post(
          Uri.parse("${ApiConstants.getPaint}access-token=$token"),

          body: {
            "album_type": album_type,
            "url": url,
            "image": image,
            "description": description
          },
          headers:
          {"Accept-Language": "$loc"}
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == 1) {
          resultAcssPrice = jsonDecode(response.body)["data"];
          emit(SendPaintLoaded(jsonDecode(response.body)["data"]["message"]));
        } else {
          emit(SendPaintFailure(jsonDecode(response.body)["data"]["message"]));
        }
      }
    } on SocketException {
      emit(SendPaintFailure(tr(StringConstants.noInternet)));
    } catch (e) {
      emit(SendPaintFailure(tr(StringConstants.problemMessageInCubit)));
    }
  }

  // start

  // sizes Of PrintWithAlbum
  AlbumSize? currentSizeForPrintAlbum;
  AlbumSize? currentSizeForWithoutPrintAlbum;
  AlbumSize? currentSizeForFillerAlbum;

  List<AlbumSize>? listOfCurrentSizeForPrintAlbum;

  void getAlbumSizeForWithPrint() {
    emit(ListsLoading());

    List<AlbumSize>? listOfCurrentSizeForPrintAlbum = dataAllMenues!.albumSizes;

    listOfCurrentSizeForPrintAlbum?.insert(
        0, AlbumSize(id: -1, name: tr(StringConstants.choice), nameEng: "choose", status: 1));
    this.listOfCurrentSizeForPrintAlbum = listOfCurrentSizeForPrintAlbum;
    currentSizeForPrintAlbum = listOfCurrentSizeForPrintAlbum![0];
    currentSizeForWithoutPrintAlbum = listOfCurrentSizeForPrintAlbum[0];
    currentSizeForFillerAlbum = listOfCurrentSizeForPrintAlbum[0];

  }

  void changeCurrentSizeForAlbumWithPrint(String name) {
    currentSizeForPrintAlbum = listOfCurrentSizeForPrintAlbum!.firstWhere(
        (element) => element.name == name || element.nameEng == name);
    emit(ChangeCurrentSizeForAlbumPrintState());
  }
 void changeCurrentSizeForFiller(String name) {
   currentSizeForFillerAlbum = listOfCurrentSizeForPrintAlbum!.firstWhere(
        (element) => element.name == name || element.nameEng == name);
    emit(ChangeCurrentSizeForFillerState());
  }

// box For albumWithPrint

  BaseIdNameModel? boxYesOrNoAlbumWithPrint;
  List<BaseIdNameModel>? listBoxOrNotForAlbumWithPrint;
  BaseIdNameModel? boxYesOrNoAlbumWithoutPrint;

  void getBoxOrNotForWithPrint() {
    emit(ListsLoading());

    listBoxOrNotForAlbumWithPrint = [];
    listBoxOrNotForAlbumWithPrint = dataAllMenues!.yesOrNoOptions;
    bool isAnotherOptionAlreadyExists =
        listBoxOrNotForAlbumWithPrint?.any((item) => item.name == tr(StringConstants.choice)) ??
            false;

    if (!isAnotherOptionAlreadyExists) {
      listBoxOrNotForAlbumWithPrint?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    boxYesOrNoAlbumWithPrint = listBoxOrNotForAlbumWithPrint![0];
    boxYesOrNoAlbumWithoutPrint = listBoxOrNotForAlbumWithPrint![0];
  }

  void changeBoxYesOrNoForWithPrint(String name) {
    boxYesOrNoAlbumWithPrint = listBoxOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeBoxYesOrNoForWithPrintState());
  }

  //extensions for albumWithPrint
  BaseIdNameModel? withExtensionOrNotForWithPrint;
  List<BaseIdNameModel>? listExtensionsOrNotForAlbumWithPrint;
  BaseIdNameModel? withExtensionOrNotForWithoutPrint;

  void getExtensionOrNotForWithPrint() {
    emit(ListsLoading());
    listExtensionsOrNotForAlbumWithPrint = [];
    listExtensionsOrNotForAlbumWithPrint = dataAllMenues!.yesOrNoOptions;

    bool isAnotherOptionAlreadyExists = listExtensionsOrNotForAlbumWithPrint
            ?.any((item) => item.name == tr(StringConstants.choice)) ??
        false;

    if (!isAnotherOptionAlreadyExists) {
      listExtensionsOrNotForAlbumWithPrint?.insert(
          0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    withExtensionOrNotForWithPrint = listExtensionsOrNotForAlbumWithPrint![0];
    withExtensionOrNotForWithoutPrint =
    listExtensionsOrNotForAlbumWithPrint![0];
  }

  void changeExtensionsYesOrNoForWithPrint(String name) {
    withExtensionOrNotForWithPrint = listExtensionsOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeExtensionYesOrNoForWithPrintState());
  }

  Extension? extensionForAlbumWithPrint;
  List<Extension>? lstExtensionWithPrint;
  Extension? extensionForAlbumWithoutPrint;

  void getListExtensionsForAlbumWithPrint() {
    emit(ListsLoading());
    lstExtensionWithPrint = [];
    lstExtensionWithPrint = dataAllMenues!.extensions;

    extensionForAlbumWithPrint = lstExtensionWithPrint![0];
    extensionForAlbumWithoutPrint = lstExtensionWithPrint![0];
  }

  String? extensionTypeSelected;

  ModelImage? modelImageForWithPrint;
  List<ModelImage>? lstModelImageForWithPrint;
  ModelImage? modelImageForWithoutPrint;

  void getModelImageWithPrint() {
    emit(ListsLoading());

    lstModelImageForWithPrint = dataAllMenues!.modelImages;

  }


  File? uploadAnotherModelOfPHOTOForAlbumWithPrint;

  getImageFromGalleryForAlbumWithPrint(file) async {
    uploadAnotherModelOfPHOTOForAlbumWithPrint= file;
      emit(UploadAnotherModelOfPHOTOForAlbumWithPrintState());

  }

  removeUploadAnotherModelOfPHOTOForAlbumWithPrint() {
    uploadAnotherModelOfPHOTOForAlbumWithPrint = null;
    emit(RemoveUploadAnotherModelOfPHOTOFromAlbumWithPrintState());
  }

  void changeModelImagesForAlbumWithPrint(int id) {
    modelImageForWithPrint =
        lstModelImageForWithPrint!.firstWhere((element) => element.id == id);
    emit(ChangeModelImagesForAlbumWithPrintState());
  }

  void makeChangeImageModelEqualNullForAlbumWithPrint() {
    modelImageForWithPrint = null;
    emit(MakeChangeImageModelEqualNullForAlbumWithPrintState());
  }

  // get IMage for mini

  String miniForAlbumWithPrint = "";

  updateMini(String mini) {
    miniForAlbumWithPrint = mini;
    emit(UpdateminiForAlbumWithPrint());
  }

  getImagesFromExtensionLikeMiniFromApi(
      {required String extension_type_id}) async {
    miniForAlbumWithPrint = extension_type_id;

    emit(GetImagesFromExtensionLikeMiniFromApiLoadingState());

    try {
      http.Response res = await http.post(
          Uri.parse(ApiConstants.getImagesFromExtensionLikeMiniFromApi),
          body: {"extension_type_id": extension_type_id},
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          print(extension_type_id);

          lstModelImageForWithPrint = List<ModelImage>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => ModelImage.fromJson(e)));
          emit(GetImagesFromExtensionLikeMiniFromApiSuccessState());
        } else {
          emit(GetImagesFromExtensionLikeMiniFromApiFailuerState(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      }
    } on SocketException {
      emit(GetImagesFromExtensionLikeMiniFromApiFailuerState(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetImagesFromExtensionLikeMiniFromApiFailuerState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  // get pages for album with print

  BaseIdNameModel? pagesForAlbumWithPrint;
  BaseIdNameModel? pagesForFiller;
  List<BaseIdNameModel>? listOfPagesForAlbumWithPrint;

  void getPagesForAlbumWithPrint() {
    emit(ListsLoading());
    listOfPagesForAlbumWithPrint = [];
    listOfPagesForAlbumWithPrint = dataAllMenues!.pages;
    bool isAnotherOptionAlreadyExists =
        listOfPagesForAlbumWithPrint?.any((item) => item.name == tr(StringConstants.choice)) ??
            false;

    if (!isAnotherOptionAlreadyExists) {
      listOfPagesForAlbumWithPrint?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    pagesForAlbumWithPrint = listOfPagesForAlbumWithPrint![0];
    pagesForFiller  = listOfPagesForAlbumWithPrint![0];
  }

  void changePagesWithAlbumPrint(String name) {
    pagesForAlbumWithPrint = listOfPagesForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangePagesWithPrintState());
  }
  void changePagesWithAFiller(String name) {
    pagesForFiller = listOfPagesForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangePagesFiller());
  }

  // withProccess

  BaseIdNameModel? withProcessOrNotForAlbumWithPrint;
  BaseIdNameModel? withProcessOrNotForFiller;

  List<BaseIdNameModel>? listProcessOrNotForAlbumWithPrint;

  void getProcessOrNotForAlbumWithPrintPrint() {
    emit(ListsLoading());
    listProcessOrNotForAlbumWithPrint = [];
    listProcessOrNotForAlbumWithPrint = dataAllMenues!.yesOrNoOptions;
    bool isAnotherOptionAlreadyExists =
        listProcessOrNotForAlbumWithPrint?.any((item) => item.name == tr(StringConstants.choice)) ??
            false;

    if (!isAnotherOptionAlreadyExists) {
      listProcessOrNotForAlbumWithPrint?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    withProcessOrNotForAlbumWithPrint = listProcessOrNotForAlbumWithPrint![0];
    withProcessOrNotForFiller = listProcessOrNotForAlbumWithPrint![0];
  }

  void changeProcessOrNotForAlbumPrint(String name) {
    withProcessOrNotForAlbumWithPrint = listProcessOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeProcessOrNotWithPrintState());
  }void changeProcessForFiller(String name) {
    withProcessOrNotForFiller = listProcessOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeProcessForFiller());
  }

  //withDesign
  BaseIdNameModel? withDesignForAlbumWithPrint;
  List<BaseIdNameModel>? listDesignOrNotForAlbumWithPrint;

  void getDesignOrNotForAlbumWithPrintPrint() {
    emit(ListsLoading());
    listDesignOrNotForAlbumWithPrint = [];
    listDesignOrNotForAlbumWithPrint = dataAllMenues!.yesOrNoOptions;
    bool isAnotherOptionAlreadyExists =
        listDesignOrNotForAlbumWithPrint?.any((item) => item.name == tr(StringConstants.choice)) ??
            false;

    if (!isAnotherOptionAlreadyExists) {
      listDesignOrNotForAlbumWithPrint?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    withDesignForAlbumWithPrint = listDesignOrNotForAlbumWithPrint![0];
    withDesignForFiller= listDesignOrNotForAlbumWithPrint![0];
  }

  BaseIdNameModel? painting;
  List<BaseIdNameModel>? listOfPainting;

  void getPainting() {
    emit(ListsLoading());
    listOfPainting = [];
    listOfPainting = dataAllMenues!.painting;
    bool isAnotherOptionAlreadyExists =
        listOfPainting?.any((item) => item.name == tr(StringConstants.choice)) ??
            false;

    if (!isAnotherOptionAlreadyExists) {
      listOfPainting?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));
    }
    painting = listOfPainting![0];
  }
  void changePainting(String name) {
    painting = listOfPainting!
        .firstWhere((element) => element.name == name);
    emit(ChangePainting());
  }




  void changeDesignOrNotForAlbumPrint(String name) {
    withDesignForAlbumWithPrint = listDesignOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeDesignOrNotWithPrintState());
  }

  String notesForDesignForAlbumWithPrint = "";

  void setNotesForDesignForAlbumWithPrint(String n) {
    notesForDesignForAlbumWithPrint = n;
    emit(SetNotesForDesignForAlbumWithPrintState());
  }

  ///

  BaseIdNameModel? withDesignForFiller;


  void changeDesignOrNotForFiller(String name) {
    withDesignForFiller= listDesignOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeDesignForFillerState());
  }

  String notesForDesignForFiller = "";

  void setNotesForDesignForFiller(String n) {
    notesForDesignForFiller = n;
    emit(SetNotesForDesignForFillerState());
  }

  ///
  ///
  ///
  // material types
  Album? albumMaterialTypeForAlbumWithPrint;
  List<Album>? listOfAlbumMaterialTypeForAlbumWithPrint;

  void getAlbumMaterialTypeForWithPrint() {
    emit(ListsLoading());
    listOfAlbumMaterialTypeForAlbumWithPrint = dataAllMenues!.albumTypes;

    listOfAlbumMaterialTypeForAlbumWithPrint?.insert(
        0,
        Album(
            price1: 0,
            price2: 0,
            price3: 0,
            id: -1,
            name: tr(StringConstants.choice),
            nameEng: "another",
            status: 1));
    albumMaterialTypeForAlbumWithPrint =
        listOfAlbumMaterialTypeForAlbumWithPrint![0];
    albumMaterialTypeForAlbumWithoutPrint= listOfAlbumMaterialTypeForAlbumWithPrint![0];
  }

  void changeAlbumMaterialTypeForAlbumWithPrint(String name) {
    albumMaterialTypeForAlbumWithPrint =
        listOfAlbumMaterialTypeForAlbumWithPrint!
            .firstWhere((element) => element.name == name);
    emit(ChangeMaterialTypeForAlbumPrintState());
  }

  CoverType? coverTypeForAlbumPrint;
  List<CoverType>? lstOfCoverType;

  void getCoverTypeForWithPrint() {
    emit(ListsLoading());
    lstOfCoverType = dataAllMenues!.coverTypes;

    lstOfCoverType?.insert(
        0, CoverType(id: -1, name: tr(StringConstants.choice), nameEng: "another", status: 1));
    coverTypeForAlbumPrint = lstOfCoverType![0];
    coverTypeForWithoutAlbumPrint = lstOfCoverType![0];
  }

  void changeCoverTypeForAlbumWithPrint(String name) {
    coverTypeForAlbumPrint =
        lstOfCoverType!.firstWhere((element) => element.name == name);
    emit(ChangeCoverTypeForAlbumPrintState());
  }

  ColorResp? colorForAlbumWithPrint;
  ColorResp? colorForAccessories;
  List<ColorResp>? lstColorForAlbumWithPrint;

  void getColorForAlbumWithPrint() {
    emit(ListsLoading());
    lstColorForAlbumWithPrint = dataAllMenues!.colorResponse;
    colorForAlbumWithPrint = lstColorForAlbumWithPrint![0];
    colorForAlbumWithoutPrint = lstColorForAlbumWithPrint![0];
    colorForAccessories = lstColorForAlbumWithPrint![0];
  }

  void changeColorTypeForAlbumWithPrint(String name) {
    colorForAlbumWithPrint = lstColorForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeColorForAlbumPrintState());
  }  void changeColorTypeForAccessories(String name) {
    colorForAccessories = lstColorForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeColorForAccessoriesState());
  }

  String anotherColorTextForPrintAlbum = "";

  void setAnotherColorTextForPrintAlbum(txt) {
    anotherColorTextForPrintAlbum = txt;
    emit(SetAnotherColorForAlbumWithPrint());
  }

  Corner? cornerForAlbumWithPrint;
  List<Corner>? lstCornerForAlbumWithPrint;

  void getCornerForAlbumWithPrint() {
    emit(ListsLoading());
    lstCornerForAlbumWithPrint = dataAllMenues!.corners;
    lstCornerForAlbumWithPrint?.insert(
        0, Corner(id: -1, name: "الزوايا", nameEng: "Corner", status: 1));

    cornerForAlbumWithPrint = lstCornerForAlbumWithPrint![0];
    cornerForAlbumWithoutPrint = lstCornerForAlbumWithPrint![0];
  }

  void changeCornerForAlbumWithPrint(String name) {
    cornerForAlbumWithPrint = lstCornerForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeCornerForAlbumPrintState());
  }

  BaseIdNameModel? withUsbForAlbumWithPrint;
  List<BaseIdNameModel>? lstWithUsbForAlbumWithPrint;

  void getWithUsbForAlbumWithPrint() {
    emit(ListsLoading());
    lstWithUsbForAlbumWithPrint = dataAllMenues!.yesOrNoOptions!;

    withUsbForAlbumWithPrint = lstWithUsbForAlbumWithPrint![1];
    withUsbForAlbumWithoutPrint = lstWithUsbForAlbumWithPrint![1];
    debugPrint("initial usb ${withUsbForAlbumWithPrint!.name}");
    debugPrint("initial usb ${withUsbForAlbumWithPrint!.id}");
  }

  void changeWithUsbForAlbumWithPrint(String id) {
    withUsbForAlbumWithPrint =
        lstWithUsbForAlbumWithPrint!.firstWhere((element) => element.id == id);
    debugPrint("changed usb ${withUsbForAlbumWithPrint!.name}");

    emit(ChangeWithUsbForAlbumWithPrintState());
  }


  ///////////
  String nameOfCouplesForAlbumPrint = "";

  void changeCoupleNamesForAlbumPrint(String couple) {
    nameOfCouplesForAlbumPrint = couple;
    emit(ChangeCouplesForAlbumPrintState());
  }

  ///

  String nameOfCouplesForAccessories = "";

  void changeCoupleNameForAccessories(String couple) {
    nameOfCouplesForAccessories = couple;
    emit(ChangeCouplesForAccessoriesState());
  }


  DrillingType? drillingTypeForAlbumWithPrint;
  List<DrillingType>? lstDrillingTypeForAlbumWithPrint;

  void getDrillingTypeForAlbumWithPrint() {
    emit(ListsLoading());
    lstDrillingTypeForAlbumWithPrint = dataAllMenues!.drillingTypes;
    lstDrillingTypeForAlbumWithPrint?.insert(
        0,
        DrillingType(
            price3: 0,
            price2: 0,
            price: 0,
            id: -1,
            name: "طريقة كتابة الاسماء",
            nameEng: "The method of writing names.",
            status: 1));

    drillingTypeForAlbumWithPrint = lstDrillingTypeForAlbumWithPrint![0];
    drillingTypeForAlbumWithoutPrint = lstDrillingTypeForAlbumWithPrint![0];
    drillingType  =  lstDrillingTypeForAlbumWithPrint![0];
  }

  void changeDrillingTypeForAlbumWithPrint(String name) {
    drillingTypeForAlbumWithPrint = lstDrillingTypeForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeDrillingTypeForAlbumWithPrintState());
  } void changeDrillingForAccessories(String name) {
    drillingType = lstDrillingTypeForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeDrillingTypeForAccessoriesState());
  }

  BaseIdNameModel? historyOfAlbumWithPrint;
  BaseIdNameModel? historyOfAccessories;
  List<BaseIdNameModel>? lstHistoryOfAlbumWithPrint;

  void getHistoryOfAlbumWithPrint() {
    emit(ListsLoading());
    lstHistoryOfAlbumWithPrint = dataAllMenues!.yesOrNoOptions!;

    historyOfAlbumWithPrint = lstHistoryOfAlbumWithPrint![1];
    historyOfAlbumWithoutPrint = lstHistoryOfAlbumWithPrint![1];
    historyOfAccessories = lstHistoryOfAlbumWithPrint![1];
    print("inital history is ${historyOfAlbumWithPrint!.name}");
  }

  void changeHistoryOfAlbumWithPrint(String id) {
    historyOfAlbumWithPrint =
        lstHistoryOfAlbumWithPrint!.firstWhere((element) => element.id == id);
    print("changed history is ${historyOfAlbumWithPrint!.name}");

    emit(ChangeHistoryOfAlbumWithPrintState());
  }void changeHistoryOfAccessories(String id) {
    historyOfAccessories =
        lstHistoryOfAlbumWithPrint!.firstWhere((element) => element.id == id);

    emit(ChangeHistoryOfAccessoriesState());
  }

  BaseIdNameModel? withFamilyAlbumWithPrint;
  List<BaseIdNameModel>? lstWithFamilyAlbumWithPrint;

  void getWithFamilyAlbumWithPrint() {
    emit(ListsLoading());
    lstWithFamilyAlbumWithPrint = dataAllMenues!.yesOrNoOptions!;

    withFamilyAlbumWithPrint = lstWithFamilyAlbumWithPrint![1];
    print("inital family is ${withFamilyAlbumWithPrint!.name}");
  }

  void changeWithFamilyAlbumWithPrint(String id) {
    withFamilyAlbumWithPrint =
        lstWithFamilyAlbumWithPrint!.firstWhere((element) => element.id == id);
    emit(ChangeWithFamilyForAlbumWithPrintState());
  }

  String historyDateForAlbumWithPrint = "";
  String historyDateForAccessories = "";

  void changeHistoryDateForDateForAccessories(String date) {
    historyDateForAccessories = date;
    emit(ChangeHistoryDateForAccessoriesState());
  }
  void changeHistoryDateForAlbumWithPrint(String date) {
    historyDateForAlbumWithPrint = date;
    emit(ChangeHistoryDateForAlbumWithPrintState());
  }

  String numOfPhotosForAlbumWithPrint = "";

  void changeNumOfPhotosForAlbumWithPrint(String num) {
    numOfPhotosForAlbumWithPrint = num;
    emit(ChangeNnumOfPhotosForAlbumWithPrintState());
  }

  SideImageSize? sideImageForAlbumWithPrint;
  List<SideImageSize>? lstSideImageForAlbumWithPrint;

  void getSideImageForAlbumWithPrint() {
    emit(ListsLoading());
    lstSideImageForAlbumWithPrint = dataAllMenues!.sideImageSizes;
    lstSideImageForAlbumWithPrint?.insert(
        0,
        SideImageSize(
            price3: 0,
            price2: 0,
            price: 0,
            id: -1,
            name: tr(StringConstants.choice),
            nameEng: "choose",
            status: 1));

    sideImageForAlbumWithPrint = lstSideImageForAlbumWithPrint![0];
  }

  void changeGetSideImageForAlbumWithPrint(String name) {
    sideImageForAlbumWithPrint = lstSideImageForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeSideImagesForAlbumWithPrintState());
  }

  //ways to upload photo

  BaseIdNameModel? wayToUploadPhotoWithPrint;
  BaseIdNameModel? wayToUploadPhotoForPaint;
  BaseIdNameModel? wayToUploadPhotoForFiller;
  List<BaseIdNameModel>? lstWayToUploadPhotoWithPrint;

  void getWayToUploadPhotoWithPrint() {
    emit(ListsLoading());
    lstWayToUploadPhotoWithPrint = dataAllMenues!.imageTypes;
    lstWayToUploadPhotoWithPrint?.insert(0, BaseIdNameModel("", tr(StringConstants.choice)));

    wayToUploadPhotoWithPrint = lstWayToUploadPhotoWithPrint![0];
    wayToUploadPhotoForFiller = lstWayToUploadPhotoWithPrint![0];
    wayToUploadPhotoForPaint = lstWayToUploadPhotoWithPrint![0];
  }

  void changeWayToUploadPhotoWithPrint(String name) {
    wayToUploadPhotoWithPrint = lstWayToUploadPhotoWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeWayToUploadAlbumWithPrintState());
  } void changeWayToUploadPhotoForfFiller(String name) {
    wayToUploadPhotoForFiller = lstWayToUploadPhotoWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeWayToUploadForFillertState());
  }void changeWayToUploadPhotoForfPaint(String name) {
    wayToUploadPhotoForPaint = lstWayToUploadPhotoWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeWayToUploadForPaintState());
  }

  String urlForAlbumWithPrint = "";

  void setUrlForAlbumWithPrint(String url) {
    urlForAlbumWithPrint = url;
    emit(SetUrlForAlbumWithPrintState());
  }
  String urlForAlbumWithPaint = "";

  void setUrlForAlbumWithPaint(String url) {
    urlForAlbumWithPaint = url;
    emit(SetUrlForAlbumWithPaintState());
  }
  String urlForFiller = "";

  void setUrlForFiller(String url) {
    urlForFiller = url;
    emit(SetUrlForFillerState());
  }

  File? selectedFileFprAlbumWithPrint;

  changeSelectedFileFprAlbumWithPrintFile(file) {
    selectedFileFprAlbumWithPrint = file;
    emit(ChangeSelectedFileFprAlbumWithPrintFileState());
  }
  File? selectedFileForPaint;

  changeSelectedFileFprAlbumWithPaintFile(file) {
    selectedFileForPaint = file;
    emit(ChangeSelectedFileFprAlbumWithPaintState());
  }
  File? selectedFileForFiller;

  changeSelectedFileForFillerFile(file) {
    selectedFileForFiller = file;
    emit(ChangeSelectedFileForFillerFileState());
  }

  // paperType

  PaperType? paperTypeForAlbumWithPrint;
  PaperType? paperTypeForFiller;
  List<PaperType>? lstPaperTypeForAlbumWithPrint;

  void getPaperTypeForAlbumWithPrint() {
    emit(ListsLoading());
    lstPaperTypeForAlbumWithPrint = dataAllMenues!.paperTypes;
    lstPaperTypeForAlbumWithPrint?.insert(
        0, PaperType(id: -1, name: tr(StringConstants.choice), nameEng: "Paper type", status: 1));

    paperTypeForAlbumWithPrint = lstPaperTypeForAlbumWithPrint![0];
    paperTypeForFiller = lstPaperTypeForAlbumWithPrint![0];
  }

  void changePaperTypeForAlbumWithPrint(String name) {
    paperTypeForAlbumWithPrint = lstPaperTypeForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangePaperTypeForAlbumWithPrintState());
  }
  void changePaperTypeForFiller(String name) {
    paperTypeForFiller = lstPaperTypeForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangePaperTypeForFillerState());
  }

  String descriptionForAlbumWithPrint = "";

  void changeDescriptionForAlbumWithPrint(String desc) {
    descriptionForAlbumWithPrint = desc;
    emit(ChangeDescriptionForAlbumWithPrintState());
  }
  String descriptionForAlbumWithPaint = "";

  void changeDescriptionForAlbumWithPaint(String desc) {
    descriptionForAlbumWithPaint = desc;
    emit(ChangeDescriptionForAlbumWithPaintState());
  }
  String descriptionForFiller = "";

  void changeDescriptionForFiller(String desc) {
    descriptionForFiller = desc;
    emit(ChangeDescriptionForFillerState());
  }

  ///////////

  /// without print



  void changeCurrentSizeForAlbumWithoutPrint(String name) {
    currentSizeForWithoutPrintAlbum = listOfCurrentSizeForPrintAlbum!
        .firstWhere(
            (element) => element.name == name || element.nameEng == name);
    emit(ChangeCurrentSizeForWithoutAlbumPrintState());
  }

// box For albumWithoutPrint

  void changeBoxYesOrNoForWithoutPrint(String name) {
    boxYesOrNoAlbumWithoutPrint = listBoxOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeBoxYesOrNoForWithoutPrintState());
  }

  //extensions for albumWithPrint


  void changeExtensionsYesOrNoForWithoutPrint(String name) {
    withExtensionOrNotForWithoutPrint = listExtensionsOrNotForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeExtensionYesOrNoForWithoutPrintState());
  }



  String? extensionTypeSelectedForWithout;



  void changeModelImageForAlbumWithoutPrint(String id) {
    modelImageForWithoutPrint = lstModelImageForWithPrint!
        .firstWhere((element) => element.id == id);
    emit(ChangeModelImagesPrintWithoutState());
  }

  File? uploadAnotherModelOfPHOTOForAlbumWithoutPrint;

  getImageFromGalleryForAlbumWithoutPrint(file) async {
    uploadAnotherModelOfPHOTOForAlbumWithoutPrint = file;
      emit(UploadAnotherModelOfPHOTOForAlbumWithoutPrintState());

  }

  removeUploadAnotherModelOfPHOTOForAlbumWithoutPrint() {
    uploadAnotherModelOfPHOTOForAlbumWithoutPrint = null;
    emit(RemoveUploadAnotherModelOfPHOTOFromAlbumWithoutPrintState());
  }

  void changeModelImagesForAlbumWithoutPrint(int id) {
    modelImageForWithoutPrint =
        lstModelImageForWithPrint!.firstWhere((element) => element.id == id);
    emit(ChangeModelImagesForAlbumWithoutPrintState());
  }


  void makeChangeImageModelEqualNullForAlbumWithoutPrint() {
    modelImageForWithoutPrint = null;
    emit(MakeChangeImageModelEqualNullForAlbumWithoutPrintState());
  }

  // get IMage for mini

  String miniForAlbumWithoutPrint = "";

  updateMiniWithoutPrint(String mini) {
    miniForAlbumWithoutPrint = mini;
    emit(UpdateminiForAlbumWithoutPrint());
  }

  getImagesFromExtensionLikeMiniFromApiWithoutPrint(
      {required String extension_type_id}) async {
    miniForAlbumWithoutPrint = extension_type_id;

    emit(GetImagesFromExtensionLikeMiniFromApiLoadingWithoutPrintState());

    try {
      http.Response res = await http.post(
          Uri.parse(
              ApiConstants.getImagesFromExtensionLikeMiniFromApiWithoutPrint),
          body: {"extension_type_id": extension_type_id},
          headers:
          {"Accept-Language": "$loc"}
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)["status"] == 1) {
          print(extension_type_id);

          lstModelImageForWithPrint = List<ModelImage>.from(
              (jsonDecode(res.body)["data"][0] as List)
                  .map((e) => ModelImage.fromJson(e)));
          emit(GetImagesFromExtensionLikeMiniFromApiSuccessWithoutPrintState());
        } else {
          emit(GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState(
              message: tr(StringConstants.problemMessageInCubit)));
        }
      }
    } on SocketException {
      emit(GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState(
          message: tr(StringConstants.noInternet)));
    } catch (e) {
      emit(GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState(
          message: tr(StringConstants.problemMessageInCubit)));
    }
  }

  // material types
  Album? albumMaterialTypeForAlbumWithoutPrint;


  void changeAlbumMaterialTypeForAlbumWithoutPrint(String name) {
    albumMaterialTypeForAlbumWithoutPrint =
        listOfAlbumMaterialTypeForAlbumWithPrint!
            .firstWhere((element) => element.name == name);
    emit(ChangeMaterialTypeForWithoutAlbumPrintState());
  }

  CoverType? coverTypeForWithoutAlbumPrint;


  void changeCoverTypeForAlbumWithoutPrint(String name) {
    coverTypeForWithoutAlbumPrint = lstOfCoverType!
        .firstWhere((element) => element.name == name);
    emit(ChangeCoverTypeForAlbumWithoutPrintState());
  }

  ColorResp? colorForAlbumWithoutPrint;



  void changeColorTypeForAlbumWithoutPrint(String name) {
    colorForAlbumWithoutPrint = lstColorForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeColorForAlbumWithoutPrintState());
  }

  String anotherColorTextForWithoutPrintAlbum = "";

  void setAnotherColorTextForWithoutPrintAlbum(txt) {
    anotherColorTextForWithoutPrintAlbum = txt;
    emit(SetAnotherColorForAlbumWithoutPrint());
  }
 String anotherColorTextForAccessories = "";

  void setAnotherColorTextForAccessories(txt) {
    anotherColorTextForAccessories = txt;
    emit(SetAnotherColorForAccessories());
  }

  Corner? cornerForAlbumWithoutPrint;


  void changeCornerForAlbumWithoutPrint(String name) {
    cornerForAlbumWithoutPrint = lstCornerForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeCornerForAlbumWithoutPrintState());
  }

  BaseIdNameModel? withUsbForAlbumWithoutPrint;

  void changeWithUsbForAlbumWithoutPrint(String id) {
    withUsbForAlbumWithoutPrint = lstWithUsbForAlbumWithPrint!
        .firstWhere((element) => element.id == id);
    debugPrint("changed usb ${withUsbForAlbumWithoutPrint!.name}");

    emit(ChangeWithUsbForAlbumWithoutPrintState());
  }
  ///
  ///
  ///
  ///

  String nameOfCouplesForWithoutAlbumPrint = "";

  void changeCoupleNamesForWithoutAlbumPrint(String couple) {
    nameOfCouplesForWithoutAlbumPrint = couple;
    emit(ChangeCouplesForWithoutAlbumPrintState());
  }

  DrillingType? drillingTypeForAlbumWithoutPrint;

  void changeDrillingTypeForAlbumWithoutPrint(String name) {
    drillingTypeForAlbumWithoutPrint = lstDrillingTypeForAlbumWithPrint!
        .firstWhere((element) => element.name == name);
    emit(ChangeDrillingTypeForAlbumWithoutPrintState());
  }

  BaseIdNameModel? historyOfAlbumWithoutPrint;


  void changeHistoryOfAlbumWithoutPrint(String id) {
    historyOfAlbumWithoutPrint = lstHistoryOfAlbumWithPrint!
        .firstWhere((element) => element.id == id);
    print("changed history is ${historyOfAlbumWithoutPrint!.name}");

    emit(ChangeHistoryOfAlbumWithoutPrintState());
  }

  String historyDateForAlbumWithoutPrint = "";

  void changeHistoryDateForAlbumWithoutPrint(String date) {
    historyDateForAlbumWithoutPrint = date;
    emit(ChangeHistoryDateForAlbumWithoutPrintState());
  }

  String descriptionForAlbumWithoutPrint = "";

  void changeDescriptionForAlbumWithoutPrint(String desc) {
    descriptionForAlbumWithoutPrint = desc;
    emit(ChangeDescriptionForAlbumWithoutPrintState());
  }
  List<bool> lstBoolForWithAlbum = [
    false,
    false,
    false,
  ];
  List<bool> lstBoolForWithoutAlbum = [
    false,
    false,
    false,
  ];
  BaseIdNameModel? accessoriesTypeForFiller;
  List<BaseIdNameModel>? lstOfAccessoriesTypeForFiller;

  void getAccessoriesType() {
    emit(ListsLoading());
    lstOfAccessoriesTypeForFiller = dataAllMenues!.accessoriesTypes;

    lstOfAccessoriesTypeForFiller?.insert(
        0, BaseIdNameModel(
        "", tr(StringConstants.choice)

    ));
    accessoriesTypeForFiller=  lstOfAccessoriesTypeForFiller![0];
  }


  List<BoardSize> ? lstBoardSize;
   void getBoardSize() {
    emit(ListsLoading());
    lstBoardSize = dataAllMenues!.boardSizes;

    lstBoardSize?.insert(
        0, BoardSize(
        id:  -1  ,
      name: tr(StringConstants.choice),
      nameEng:"Choose" ,
      price: 0,
      status: 1

    ));
    boardSizeAcceso = lstBoardSize![0];
  }
  List<PrintSize> ? lstPrintSize;
   void getPrintSize() {
    emit(ListsLoading());
    lstPrintSize = dataAllMenues!.printSizes;

    lstPrintSize?.insert(
        0, PrintSize(
        id:  -1  ,
      name: tr(StringConstants.choice),
      nameEng:"Choose" ,
      price: 0,
      status: 1

    ));
    printSize = lstPrintSize![0];
  }


bool   emptyOrNotPage1InAlbumWithPrint  = false;
   updateEmptyOrNotPage1InAlbumWithPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage1InAlbumWithPrint= b;
     emit(ChangeEmptyOrNotPage1InAlbumWithPrint());
   }

bool   emptyOrNotPage2InAlbumWithPrint  = false;
   updateEmptyOrNotPage2InAlbumWithPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage2InAlbumWithPrint= b;
     emit(ChangeEmptyOrNotPage2InAlbumWithPrint());
   }

bool   emptyOrNotPage3InAlbumWithPrint  = false;
   updateEmptyOrNotPage3InAlbumWithPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage3InAlbumWithPrint= b;
     emit(ChangeEmptyOrNotPage3InAlbumWithPrint());
   }


bool   emptyOrNotPage4InAlbumWithPrint  = false;
   updateEmptyOrNotPage4InAlbumWithPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage4InAlbumWithPrint= b;
     emit(ChangeEmptyOrNotPage4InAlbumWithPrint());
   }



bool   emptyOrNotPage1InAlbumWithoutPrint  = false;
   updateEmptyOrNotPage1InAlbumWithoutPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage1InAlbumWithoutPrint= b;
     emit(ChangeEmptyOrNotPage1InAlbumWithoutPrint());
   }
bool   emptyOrNotPage2InAlbumWithoutPrint  = false;
   updateEmptyOrNotPage2InAlbumWithoutPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage2InAlbumWithoutPrint= b;
     emit(ChangeEmptyOrNotPage2InAlbumWithoutPrint());
   }
bool   emptyOrNotPage3InAlbumWithoutPrint  = false;
   updateEmptyOrNotPage3InAlbumWithoutPrint
       ( {
  required  bool b
}) {
     emptyOrNotPage3InAlbumWithoutPrint= b;
     emit(ChangeEmptyOrNotPage3InAlbumWithoutPrint());
   }
bool   emptyOrNotPage1InAlbumFiller  = false;
   updateEmptyOrNotPage1InAlbumFiller
       ( {
  required  bool b
}) {
     emptyOrNotPage1InAlbumFiller= b;
     emit(ChangeEmptyOrNotPage1InAlbumFiller());
   }

bool   emptyOrNotPage1InAlbumAccessories  = false;
   updateEmptyOrNotPage1InAlbumAccessories
       ( {
  required  bool b
}) {
     emptyOrNotPage1InAlbumAccessories= b;
     emit(ChangeEmptyOrNotPage1InAlbumAccessories());
   }

bool   emptyOrNotInAlbumLPaint  = false;
   updateEmptyOrNotInAlbumLPaint
       ( {
  required  bool b
}) {
     emptyOrNotInAlbumLPaint= b;
     emit(ChangeEmptyOrNotInAlbumLPaint());
   }




   restartEmptyOrNotPage1InAlbumWithPrint() {
     emptyOrNotPage1InAlbumWithPrint = false ;
     emptyOrNotPage2InAlbumWithPrint = false ;
     emit(RestartEmptyOrNotPage1InAlbumWithPrint());


   }



}
