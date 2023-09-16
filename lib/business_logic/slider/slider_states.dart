abstract class SliderStates { }
class ChangeSliderIndexState extends SliderStates { }
class InitialSliderState extends SliderStates { }




class BottomSliderStateSuccess extends SliderStates { }
class BottomSliderStateFailure extends SliderStates {
  final String message;

  BottomSliderStateFailure({required this.message});
}
class BottomSliderStateLoading extends SliderStates { }
class BottomSliderStateNoInternet extends SliderStates {
  final String message;

  BottomSliderStateNoInternet({required this.message});
}
class ChangeLanguageDoneState extends SliderStates { }