part of 'change_points_cubit.dart';

abstract class ChangePointsState {}

class ChangePointsInitial extends ChangePointsState {}
class LoadingChangePointsState extends ChangePointsState{}
class SuccessChangePointsState extends ChangePointsState{
  final String message;

  SuccessChangePointsState({required this.message});
}
class ErrorChangePointsState extends ChangePointsState{
  final String message;

  ErrorChangePointsState({required this.message});
}

