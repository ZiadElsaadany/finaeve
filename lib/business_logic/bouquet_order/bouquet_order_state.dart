part of 'bouquet_order_cubit.dart';

abstract class BouquetOrderState {}

class BouquetOrderInitial extends BouquetOrderState {}

class SuccessPostBouquetOrderState extends BouquetOrderState {
  final String message;

  SuccessPostBouquetOrderState({required this.message});
}

class LoadingPostBouquetOrderState extends BouquetOrderState {}

class FailurePostBouquetOrderState extends BouquetOrderState {
  final String message;

  FailurePostBouquetOrderState({required this.message});
}
