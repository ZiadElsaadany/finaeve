part of 'print_price_cubit.dart';

abstract class PrintPriceState {}

class PrintPriceInitial extends PrintPriceState {}

class PrintPriceLoading extends PrintPriceState {}

class PrintPriceLoaded extends PrintPriceState {}

class PrintPriceFailure extends PrintPriceState {
  final String message;

  PrintPriceFailure({required this.message});
}
