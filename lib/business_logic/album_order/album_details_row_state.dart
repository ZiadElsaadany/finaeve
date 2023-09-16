part of 'album_details_row_cubit.dart';

abstract class AlbumDetailsRowState {}

class AlbumDetailsRowInitial extends AlbumDetailsRowState {}

class AlbumDetailsRowStatus implements AlbumDetailsRowState{

}

class ChangeIndexOfRequestAlbumState extends AlbumDetailsRowState { }
class RestartIndexOfRequestAlbumState extends AlbumDetailsRowState { }
class MinusIndexOfRequestWithoutPrintAlbumState extends AlbumDetailsRowState { }
class MinusIndexOfRequestAlbumState extends AlbumDetailsRowState { }
class RestartAlbumPrintState extends AlbumDetailsRowState { }

class ChangeIndexOfAlbumPrintState extends AlbumDetailsRowState { }
class PlusIndexOfAlbumPrintState extends AlbumDetailsRowState { }
class ChangeColor extends AlbumDetailsRowState { }
class SetIndexOfCircleAvatarInAlbumWithoutPrint extends AlbumDetailsRowState { }
class PlusIndexOfCircleAvatarInAlbumWithoutPrint extends AlbumDetailsRowState { }
class SendRequestForPrintWithLoadingMagazine extends AlbumDetailsRowState { }
class SendRequestForSuccessMagazineStates extends AlbumDetailsRowState {
  final String message ;
  SendRequestForSuccessMagazineStates (
  {
    required this.message
}
      ) ;
}
class SendRequestForFailureMagazineStates extends AlbumDetailsRowState {
  final String message ;
  SendRequestForFailureMagazineStates (
      {
        required this.message
      }
      ) ;
}
class RestartIndexOfAlbumWithoutCircleAvatarPrintState extends AlbumDetailsRowState { }


class SendRequestInitialStates extends  AlbumDetailsRowState{ }
class SendRequestLoadingStates extends  AlbumDetailsRowState{ }
class SendRequestSuccessStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestSuccessStates (
      {
        required  this.message
      }
      );
}
class SendRequestFailureStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestFailureStates (
      {
        required  this.message
      }
      );
}
class SendRequestLoadingWithoutAlbumStates extends  AlbumDetailsRowState{ }
class SendRequestSuccessWithoutAlbumStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestSuccessWithoutAlbumStates (
      {
        required  this.message
      }
      );
}
class SendRequestFailureWithoutAlbumStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestFailureWithoutAlbumStates (
      {
        required  this.message
      }
      );
}


class SendRequestForPrintWithFillerLoadingStates extends  AlbumDetailsRowState{ }
class SendRequestForPrintWithFillerSuccessStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForPrintWithFillerSuccessStates (
      {
        required  this.message
      }
      );
}
class SendRequestForPrintWithFillerFailureStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForPrintWithFillerFailureStates (
      {
        required  this.message
      }
      );
}
class SendRequestForPrintWithLoadingAccessories extends  AlbumDetailsRowState{ }
class SendRequestForSuccessAccessoriesStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForSuccessAccessoriesStates (
      {
        required  this.message
      }
      );
}
class SendRequestForFailureAccessoriesStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForFailureAccessoriesStates (
      {
        required  this.message
      }
      );
}
class SendRequestForPrintWithPaintLoadingStates extends  AlbumDetailsRowState{ }
class SendRequestForPrintWithPaintSuccessStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForPrintWithPaintSuccessStates (
      {
        required  this.message
      }
      );
}
class SendRequestForPrintWithPaintFailureStates extends  AlbumDetailsRowState{
  final String message  ;
  SendRequestForPrintWithPaintFailureStates (
      {
        required  this.message
      }
      );
}