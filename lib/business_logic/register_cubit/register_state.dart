part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final String message ;
  RegisterLoaded (
  {
  required this.message
  }
      );
}


class RegisterFailure extends RegisterState {
  final String message ;
  RegisterFailure (
  {
    required this.message
}
      );
}
