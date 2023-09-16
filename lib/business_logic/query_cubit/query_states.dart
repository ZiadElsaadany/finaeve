abstract class QueryStates{ }
class InitialQueryState extends QueryStates{}
class LoadingQueryState extends QueryStates{}
class SuccessQueryState extends QueryStates{}
class FailureQueryState extends QueryStates{
  final String message;
  FailureQueryState(
  {
    required this.message
}
      );
}