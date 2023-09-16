part of 'get_image_comments_cubit.dart';

abstract class GetImageCommentsState {}

class GetImageCommentsInitial extends GetImageCommentsState {}

class GetImageCommentsLoading extends GetImageCommentsState {}

class GetImageCommentsLoaded extends GetImageCommentsState {}

class GetImageCommentsFailure extends GetImageCommentsState {
  final String message;
  GetImageCommentsFailure({required this.message});
}
