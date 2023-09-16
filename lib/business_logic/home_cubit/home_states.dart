abstract class HomeStates{ }

class InitialHomeState extends HomeStates { }
class ChangeBottomNavBarState extends HomeStates { }


class ChangeLoginPasswordEyes extends HomeStates { }




class GetSliderSuccess extends HomeStates{}
class GetSliderLoading extends HomeStates{}
class GetSliderFailure extends HomeStates{
  final String message ;
  GetSliderFailure(
  {
    required this.message
}
      );
}


