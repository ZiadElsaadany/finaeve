import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String message;
  final int status;

  const RegisterModel({required this.message, required this.status});
  factory RegisterModel.fromjson(Map<String, dynamic> json) =>
      RegisterModel(message: json["message"], status: json["status"]);

  @override
  List<Object?> get props => [message, status];
}

class RegisterModelFailure extends Equatable {
  final String message;
  final String field;

  const RegisterModelFailure({required this.message, required this.field});
  factory RegisterModelFailure.fromjson(Map<String, dynamic> json) =>
      RegisterModelFailure(message: json["message"], field: json["field"]);

  @override
  List<Object?> get props => [message, field];
}
