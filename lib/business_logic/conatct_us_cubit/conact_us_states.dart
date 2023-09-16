abstract class ContactStates  { }
class InitialContact extends ContactStates { }

class LoadingContactUsState extends ContactStates { }
class FailureContactUsState extends ContactStates {


  final String message;
  FailureContactUsState(
  {
    required this.message
}
      );

}
class SuccessContactUsState extends ContactStates { }


class LoadingPostContactUsState extends ContactStates { }
class FailurePostContactUsState extends ContactStates {


  final String message;
  FailurePostContactUsState(
  {
    required this.message
}
      );

}
class SuccessPostContactUsState extends ContactStates {

  final String message;
  SuccessPostContactUsState(
      {
        required this.message
      }
      );
}