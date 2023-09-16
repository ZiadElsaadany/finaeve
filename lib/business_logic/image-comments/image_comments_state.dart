part of 'image_comments_cubit.dart';

abstract class ImageCommentsState {}

class PostImageCommentsInitial extends ImageCommentsState {}

class PostImageCommentsLoading extends ImageCommentsState {}

class PostImageCommentsLoaded extends ImageCommentsState {
  final String message;
  PostImageCommentsLoaded({required this.message});
}

class PostImageCommentsFailure extends ImageCommentsState {
  final String message;
  PostImageCommentsFailure({required this.message});
}
