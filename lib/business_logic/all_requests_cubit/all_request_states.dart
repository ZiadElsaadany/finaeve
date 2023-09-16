import '../../peresentation/models/my_orders_archieve_model.dart';

abstract class AllRequestStates {}

class AllRequestInitial extends AllRequestStates {}

class ChangeRequestSelect extends AllRequestStates {}

class MyOrdersArchiveInitial extends AllRequestStates {}

class SuccessMyOrdersArchiveState extends AllRequestStates {}

class LoadingMyOrdersArchiveState extends AllRequestStates {}

class MyOrdersArchiveStateLoaded extends AllRequestStates {
  List<MyOrdersArchive> archiveOrders = [];
  List<MyOrdersArchive> inProgressOrders = [];
  List<MyOrdersArchive> endedOrders = [];

  MyOrdersArchiveStateLoaded(
      {required this.archiveOrders,
      required this.inProgressOrders,
      required this.endedOrders});
}

class FailureMyOrdersArchiveState extends AllRequestStates {
  final String message;

  FailureMyOrdersArchiveState({required this.message});
}

class LoadingShowRequest extends AllRequestStates {}

class SuccessShowRequest extends AllRequestStates {}

class FailureShowRequest extends AllRequestStates {
  final String message;

  FailureShowRequest({required this.message});
}
