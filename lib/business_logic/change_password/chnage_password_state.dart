part of 'chnage_password_cubit.dart';

abstract class ChnagePasswordState {}

class ChnagePasswordInitial extends ChnagePasswordState {}

class ChnagePasswordLoading extends ChnagePasswordState {}

class ChnagePasswordFailure extends ChnagePasswordState {
  final String message;
  ChnagePasswordFailure({required this.message});
}

class ChnagePasswordLoaded extends ChnagePasswordState {
  final String message;
  ChnagePasswordLoaded({required this.message});
}
