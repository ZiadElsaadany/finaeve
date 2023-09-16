part of 'our_services_cubit.dart';

abstract class OurServicesState {}

class OurServicesInitial extends OurServicesState {}

class LoadingStateOurServices extends OurServicesState {}

class SuccessStateOurServices extends OurServicesState {}

class ErrorStateOurServices extends OurServicesState {
  final String message;

  ErrorStateOurServices(this.message);
}
