import 'package:equatable/equatable.dart';

class ImagesComment extends Equatable {
  final String userName;
  final String commentText;
  final String createdAt;
  final int commentId;
  final int userType;
  final int userId;

  const ImagesComment({
    required this.userId,
    required this.userName,
    required this.commentId,
    required this.commentText,
    required this.createdAt,
    required this.userType
  });

  @override
  List<Object?> get props =>
      [userName, commentText, createdAt, commentId, userId];
  factory ImagesComment.fromjson(Map<String, dynamic> json) => ImagesComment(
      userName: json['user_id']['name'],
      commentText: json['comment'],
      createdAt: json['created_at'],
      commentId: json['id'],
      userId: json['user_id']['id'],
    userType: json['user_id']['user_type'],

  )

  ;
}
