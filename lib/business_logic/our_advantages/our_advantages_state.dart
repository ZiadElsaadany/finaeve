part of 'our_advantages_cubit.dart';

abstract class OurAdvantagesState {}

class OurAdvantagesInitial extends OurAdvantagesState {}

class OurAdvantagesSuccessState extends OurAdvantagesState {}

class OurAdvantagesLoadingState extends OurAdvantagesState {}

class OurAdvantagesFailureState extends OurAdvantagesState {
  final String message;

  OurAdvantagesFailureState({required this.message});
}
