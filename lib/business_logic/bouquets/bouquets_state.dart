part of 'bouquets_cubit.dart';

abstract class BouquetsState {}

class BouquetsInitial extends BouquetsState {}
class SuccessBouquets extends BouquetsState {}
class LoadingBouquets extends BouquetsState {}
class FailureBouquets extends BouquetsState {
  final String message;

  FailureBouquets({required this.message});
}
class BouquetsLoaded extends BouquetsState {
  List<BouquetsModel> bouquets = [];

  BouquetsLoaded({required this.bouquets});
}

