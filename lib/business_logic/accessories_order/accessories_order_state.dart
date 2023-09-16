part of 'accessories_order_cubit.dart';

abstract class AccessoriesOrderState {}

class AccessoriesOrderInitial extends AccessoriesOrderState {}

class LoadingAccessoriesOrderState extends AccessoriesOrderState {}

class SuccessAccessoriesOrderState extends AccessoriesOrderState {
  final String message;

  SuccessAccessoriesOrderState({required this.message});
}

class ErrorAccessoriesOrderState extends AccessoriesOrderState {
  final String message;

  ErrorAccessoriesOrderState({required this.message});
}
