part of 'lists_cubit.dart';

abstract class ListsState {}

class ListsInitial extends ListsState {}

class ListsLoading extends ListsState {}

class ListsLoaded extends ListsState {

  ListsLoaded();
}

class ListsFailure extends ListsState {
  final String message;

  ListsFailure(this.message);
}


class ChangeCurrentSizeForAlbumPrintState extends ListsState {}


class ChangeOptionsState extends ListsState {}
class ChangeAccessoriesTypeState extends ListsState {}
class ChangeBoxYesOrNoForWithPrintState extends ListsState {}
class ChangeExtensionYesOrNoForWithPrintState extends ListsState {}
class ChangeModelImagesPrintState extends ListsState {}
class UploadAnotherModelOfPHOTOForAlbumWithPrintState extends ListsState {}
class RemoveUploadAnotherModelOfPHOTOFromAlbumWithPrintState extends ListsState {}
class ChangeModelImagesForAlbumWithPrintState extends ListsState {}
class MakeChangeImageModelEqualNullForAlbumWithPrintState extends ListsState {}
class GetImagesFromExtensionLikeMiniFromApiFailuerState extends ListsState {
  final String message;
  GetImagesFromExtensionLikeMiniFromApiFailuerState(
  {
    required this.message
}
      );
}
class GetImagesFromExtensionLikeMiniFromApiLoadingState extends ListsState {}
class GetImagesFromExtensionLikeMiniFromApiSuccessState extends ListsState {}
class ChangePagesWithPrintState extends ListsState {}
class ChangeProcessOrNotWithPrintState extends ListsState {}
class ChangeDesignOrNotWithPrintState extends ListsState {}
class SetNotesForDesignForAlbumWithPrintState extends ListsState {}
class UpdateminiForAlbumWithPrint extends ListsState {}
class ChangeMaterialTypeForAlbumPrintState extends ListsState {}
class ChangeCoverTypeForAlbumPrintState extends ListsState {}
class ChangeColorForAlbumPrintState extends ListsState {}
class SetAnotherColorForAlbumWithPrint extends ListsState {}
class ChangeCornerForAlbumPrintState extends ListsState {}
class ChangeWithUsbForAlbumWithPrintState extends ListsState {}
class ChangeCouplesForAlbumPrintState extends ListsState {}
class ChangeDrillingTypeForAlbumWithPrintState extends ListsState {}
class ChangeHistoryOfAlbumWithPrintState extends ListsState {}
class ChangeWithFamilyForAlbumWithPrintState extends ListsState {}
class ChangeHistoryDateForAlbumWithPrintState extends ListsState {}
class ChangeNnumOfPhotosForAlbumWithPrintState extends ListsState {}
class ChangeSideImagesForAlbumWithPrintState extends ListsState {}
class ChangeWayToUploadAlbumWithPrintState extends ListsState {}
class SetUrlForAlbumWithPrintState extends ListsState {}
class ChangeSelectedFileFprAlbumWithPrintFileState extends ListsState {}
class ChangePaperTypeForAlbumWithPrintState extends ListsState {}
class ChangeDescriptionForAlbumWithPrintState extends ListsState {}
class ChangeCurrentSizeForFillerState extends ListsState {}
class ChangePagesFiller extends ListsState {}
class ChangeProcessForFiller extends ListsState {}
class ChangePainting extends ListsState {}
class ChangeDesignForFillerState extends ListsState {}
class SetNotesForDesignForFillerState extends ListsState {}
class ChangeWayToUploadForFillertState extends ListsState {}
class SetUrlForFillerState extends ListsState {}
class ChangeSelectedFileForFillerFileState extends ListsState {}
class ChangePaperTypeForFillerState extends ListsState {}
class ChangeDescriptionForFillerState extends ListsState {}
class ChangeAccessoriesTypecState extends ListsState {}
class ChangeCouplesForAccessoriesState extends ListsState {}
class ChangeDrillingTypeForAccessoriesState extends ListsState {}
class ChangeHistoryDateForAccessoriesState extends ListsState {}
class ChangeColorForAccessoriesState extends ListsState {}
class ChangeHistoryOfAccessoriesState extends ListsState {}
class ChangeWayToUploadForPaintState extends ListsState {}
class SetUrlForAlbumWithPaintState extends ListsState {}
class ChangeSelectedFileFprAlbumWithPaintState extends ListsState {}
class ChangeDescriptionForAlbumWithPaintState extends ListsState {}


class ChangePagesState extends ListsState {}
class ChangePagesDesignerState extends ListsState {}
  class ChangeExtensionState extends ListsState {}
  class ChangeAlbumTypeState extends ListsState {}

class ChangeCornerState extends ListsState {}

class ChangeWithUsbState extends ListsState {}
class ChangeDrillingTypeState extends ListsState {}
class ChangeColorState extends ListsState {}
class ChangeDateState extends ListsState {}
class ChangePhotoFamilyState extends ListsState {}
class RestartProcessState extends ListsState {}
class SidePhotosState extends ListsState {}
class ImageTypesState extends ListsState {}
class PaperTypesState extends ListsState {}
class ChangeboardSizeAccesoState extends ListsState {}
class ChangePrintSizeState extends ListsState {}
class WithExtensionOrNotState extends ListsState {}
class ModelImagesState extends ListsState {}
class GetImageFromGalleryState extends ListsState {}
class MakeChangeImageModelEqualNullState extends ListsState {}
class RemoveUploadAnotherModelOfPHOTOState extends ListsState {}
class SetNotesStates extends ListsState {}
class ChangeHistoryDateState extends ListsState {}
class ChangeNumOfPhotosState extends ListsState {}
class ChangeCouplesState extends ListsState {}
class ChangeSelectedFileState extends ListsState {}
class ChangeDescriptionForAccessoriesState extends ListsState {}
class SetAnotherColorText extends ListsState {}
class SetUrlState extends ListsState {}
class SetAnotherColorForAccessories extends ListsState {}



class AlbumPriceInitial extends ListsState {}

class AlbumPriceLoading extends ListsState {}

class AlbumPriceLoaded extends ListsState {}
class GetpriceState extends ListsState {}

class AlbumPriceFailure extends ListsState {
  final String message ;
  AlbumPriceFailure(
      {
        required this.message
      }
      ) ;
}
class RestartPriceState extends ListsState{ }
class InitialPrice extends ListsState{ }

class SendAccessoriesOrderLoading extends ListsState{ }
class SendAccessoriesOrderLoaded extends ListsState{
  final String message;
  SendAccessoriesOrderLoaded(
  {
    required this.message
}
      );
}
class SendAccessoriesOrderFailure extends ListsState{
  final String message;
  SendAccessoriesOrderFailure(
      {
        required this.message
      }
      );
}




class GetBoardPriceLoading extends ListsState{ }
class GetBoardPriceLoaded extends ListsState{

}
class GetBoardPriceFailure extends ListsState{
  final String message;
  GetBoardPriceFailure(
      {
        required this.message
      }
      );
}

class RestartBoard extends ListsState{ }



class GetPrintPriceLoading extends ListsState { }
class GetPrintPriceFailure extends ListsState {
  final String message;
  GetPrintPriceFailure(
  {
    required this.message
}
      );
}
class GetPrintPriceLoaded extends  ListsState{  }

class GetAccessoriePriceLoading extends ListsState { }
class GetAccessoriePriceFailure extends ListsState {
  final String message;
  GetAccessoriePriceFailure(
  {
    required this.message
}
      );
}
class GetAccessoriePriceLoaded extends  ListsState{  }
class GetPriceToAccessoriesState extends  ListsState{  }
class SendPaintLoading extends  ListsState{  }
class SendPaintFailure extends  ListsState{
  final String message ;
  SendPaintFailure(
      this.message
      );
}
class SendPaintLoaded extends  ListsState{
  final String message ;
  SendPaintLoaded(
      this.message
      );
}






class ChangeCurrentSizeForWithoutAlbumPrintState extends ListsState { }
class ChangeMaterialTypeForWithoutAlbumPrintState extends ListsState { }
class ChangeCoverTypeForAlbumWithoutPrintState extends ListsState { }
class SetAnotherColorForAlbumWithoutPrint extends ListsState { }
class ChangeColorForAlbumWithoutPrintState extends ListsState { }
class ChangeCornerForAlbumWithoutPrintState extends ListsState { }
class ChangeWithUsbForAlbumWithoutPrintState extends ListsState { }
class ChangeCouplesForWithoutAlbumPrintState extends ListsState { }
class ChangeDrillingTypeForAlbumWithoutPrintState extends ListsState { }
class ChangeHistoryOfAlbumWithoutPrintState extends ListsState { }
class ChangeHistoryDateForAlbumWithoutPrintState extends ListsState { }
class ChangeDescriptionForAlbumWithoutPrintState extends ListsState { }
class ChangeBoxYesOrNoForWithoutPrintState extends ListsState { }
class ChangeExtensionYesOrNoForWithoutPrintState extends ListsState { }
class ChangeModelImagesPrintWithoutState extends ListsState { }
class UploadAnotherModelOfPHOTOForAlbumWithoutPrintState extends ListsState { }
class RemoveUploadAnotherModelOfPHOTOFromAlbumWithoutPrintState extends ListsState { }
class ChangeModelImagesForAlbumWithoutPrintState extends ListsState { }
class MakeChangeImageModelEqualNullForAlbumWithoutPrintState extends ListsState { }
class UpdateminiForAlbumWithoutPrint extends ListsState { }
class GetImagesFromExtensionLikeMiniFromApiSuccessWithoutPrintState extends ListsState { }
class GetImagesFromExtensionLikeMiniFromApiLoadingWithoutPrintState extends ListsState { }
class RestartEmptyOrNotPage1InAlbumWithPrint extends ListsState { }
class ChangeEmptyOrNotPage1InAlbumWithPrint extends ListsState { }
class ChangeEmptyOrNotPage2InAlbumWithPrint extends ListsState { }
class ChangeEmptyOrNotPage3InAlbumWithPrint extends ListsState { }
class ChangeEmptyOrNotPage4InAlbumWithPrint extends ListsState { }
class ChangeEmptyOrNotPage1InAlbumWithoutPrint extends ListsState { }
class ChangeEmptyOrNotPage2InAlbumWithoutPrint extends ListsState { }
class ChangeEmptyOrNotPage3InAlbumWithoutPrint extends ListsState { }
class ChangeEmptyOrNotPage1InAlbumFiller extends ListsState { }
class ChangeEmptyOrNotPage1InAlbumAccessories extends ListsState { }
class ChangeEmptyOrNotInAlbumLPaint extends ListsState { }
class RestartAllListsState extends ListsState { }
class GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState extends ListsState {
  final String message ;
  GetImagesFromExtensionLikeMiniFromApiFailuerWithoutPrintState(
  {
    required this.message
}
      );
}



// start

