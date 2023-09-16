part of 'paint_order_cubit.dart';

abstract class PaintOrderState {}

class PaintOrderInitial extends PaintOrderState {}
class LoadingPaintOrderState extends PaintOrderState {}

class SuccessPaintOrderState extends PaintOrderState {
  final String message;

  SuccessPaintOrderState({required this.message});
}

class ErrorPaintOrderState extends PaintOrderState {
  final String message;

  ErrorPaintOrderState({required this.message});
}
