part of 'accessory_price_cubit.dart';

abstract class AccessoryPriceState {}

class AccessoryPriceInitial extends AccessoryPriceState {}

class AccessoryPriceLoading extends AccessoryPriceState {}

class AccessoryPriceLoaded extends AccessoryPriceState {}

class AccessoryPriceFailure extends AccessoryPriceState {
  final String message;

  AccessoryPriceFailure({required this.message});
}
