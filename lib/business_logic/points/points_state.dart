part of 'points_cubit.dart';

abstract class PointsState {}

class PointsInitial extends PointsState {}

class LoadingPointsState extends PointsState {}

class SuccessPointsState extends PointsState {}

class IsSelectedPointsState extends PointsState {}

class IsNotSelectedPointsState extends PointsState {}

class PointsLoaded extends PointsState {
  final List<PointsModel> points;

  PointsLoaded({required this.points});
}

class ErrorPointsState extends PointsState {
  final String message;

  ErrorPointsState(this.message);
}
