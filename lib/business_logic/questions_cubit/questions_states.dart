abstract class QuestionsStates{ }
class QuestionInitial extends QuestionsStates{}
class GetQuestionsSuccess extends QuestionsStates{}
class GetQuestionsLoading extends QuestionsStates{}
class GetQuestionsFailure extends QuestionsStates{
  final String message;

  GetQuestionsFailure({required this.message});
}
class GetQuestionsNoInternet extends QuestionsStates{
  final String message;

  GetQuestionsNoInternet({required this.message});
}

class GetWhatSaySuccess extends QuestionsStates{}
class GetWhatSayLoading extends QuestionsStates{}
class GetWhatSayFailure extends QuestionsStates{
  final String message;

  GetWhatSayFailure({required this.message});
}
class GetWhatSayNoInternet extends QuestionsStates{
  final String message;

  GetWhatSayNoInternet({required this.message});
}


class GetEveSuccess extends QuestionsStates{}
class GetEveLoading extends QuestionsStates{}
class GetEveFailure extends QuestionsStates{
  final String message;

  GetEveFailure({required this.message});
}
class GetEveNoInternet extends QuestionsStates{
  final String message;

  GetEveNoInternet({required this.message});
}


