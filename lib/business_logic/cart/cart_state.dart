part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class LoadingCartState extends CartState {}

class SuccessCartState extends CartState {}

class FailureCartState extends CartState {
  final String message;

  FailureCartState({required this.message});
}

class LoadingDelCartState extends CartState {}

class SuccessDelCartState extends CartState {
  final String message;
  SuccessDelCartState({required this.message});
}

class FailureDelCartState extends CartState {
  final String message;

  FailureDelCartState({required this.message});
}

class LoadingOrderDoneState extends CartState {}

class SuccessOrderDoneState extends CartState {
  final String message;
  SuccessOrderDoneState({required this.message});
}

class FailureOrderDoneState extends CartState {
  final String message;

  FailureOrderDoneState({required this.message});
}
