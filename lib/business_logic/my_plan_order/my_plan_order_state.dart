part of 'my_plan_order_cubit.dart';

abstract class MyPlanOrderState {}

class MyPlanOrderInitial extends MyPlanOrderState {}
class SuccessMyPlanOrderState extends  MyPlanOrderState{}
class LoadingMyPlanOrderState extends  MyPlanOrderState{}
class FailureMyPlanOrderState extends  MyPlanOrderState{
  final String message;

FailureMyPlanOrderState({required this.message});
}
class MyPlanOrderStateLoaded extends MyPlanOrderState {
  List<MyPlanOrderModel> myPlanOrder=[];

  MyPlanOrderStateLoaded({required this.myPlanOrder});
}

