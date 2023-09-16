abstract class WorksStates  { }
class WorksLoading  extends WorksStates { }
class WorksLoaded  extends WorksStates { }
class WorksInitial  extends WorksStates { }
class WorksFailure  extends WorksStates {
  final String message ;
  WorksFailure(
  {
    required this.message
}
      );
}

class ChangeItemState  extends WorksStates { }
class RestartChangeItemState  extends WorksStates { }

class WorksDepartmentLoading  extends WorksStates { }
class WorksDepartmentLoaded  extends WorksStates { }
class WorksDepartmentFailure  extends WorksStates {
  final String message ;
  WorksDepartmentFailure(
  {
    required this.message
}
      );
}