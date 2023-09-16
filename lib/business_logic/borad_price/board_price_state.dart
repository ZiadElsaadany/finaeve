part of 'board_price_cubit.dart';

abstract class BoardPriceState {}

class BoardPriceInitial extends BoardPriceState {}

class BoardPriceLoading extends BoardPriceState {}

class BoardPriceLoaded extends BoardPriceState {}

class BoardPriceFailure extends BoardPriceState {
  final String message;

  BoardPriceFailure({required this.message});
}
