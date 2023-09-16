part of 'orders_cubit.dart';


abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersAddOrderLoadingState extends OrdersState {}

class OrdersAddOrderSuccessState extends OrdersState {}

class OrdersAddOrderErrorState extends OrdersState {
  final String message;

  OrdersAddOrderErrorState({required this.message});
}

class OrdersAddOrderNoInternetState extends OrdersState {
  final String message;

  OrdersAddOrderNoInternetState({required this.message});
}
