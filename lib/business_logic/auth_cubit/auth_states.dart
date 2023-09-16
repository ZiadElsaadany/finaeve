abstract class AuthStates { }
 class InitialAuth extends AuthStates{ }
 class ChangeVisibleOldPass extends AuthStates { }
 class ChangeVisibleNewPass extends AuthStates { }
 class ChangeVisibleConfirmPass extends AuthStates { }




 class   LoginLoading extends AuthStates { }
 class   LoginSuccess extends AuthStates {
 final String  loginSuccess;
 LoginSuccess(
 {
  required this.loginSuccess,
 }
     );
 }
 class   LoginFailure extends AuthStates {
  final String  loginFailureMessage;
  LoginFailure(
  {
   required this.loginFailureMessage
 }
      );
 }


 class   UpdateLoginLoading extends AuthStates { }
 class   UpdateLoginSuccess extends AuthStates {
 final String  loginSuccess;
 UpdateLoginSuccess(
 {
  required this.loginSuccess,
 }
     );
 }
 class   UpdateLoginFailure extends AuthStates {
  final String  loginFailureMessage;
  UpdateLoginFailure(
  {
   required this.loginFailureMessage
 }
      );
 }

 class   ForgetPasswordLoading extends AuthStates { }
 class   ForgetPasswordSuccess extends AuthStates {
 final String  loginSuccess;
 ForgetPasswordSuccess(
 {
  required this.loginSuccess,
 }
     );
 }
 class   ForgetPasswordLoginFailure extends AuthStates {
  final String  loginFailureMessage;
  ForgetPasswordLoginFailure(
  {
   required this.loginFailureMessage
 }
      );
 }

 class GetImageFromGallery extends AuthStates { }
 class  UpdateProfileLoading extends AuthStates { }
 class   UpdateProfileSuccess extends AuthStates {
 final String  loginSuccess;
 UpdateProfileSuccess(
 {
  required this.loginSuccess,
 }
     );
 }
 class   UpdateProfileFailure extends AuthStates {
  final String  loginFailureMessage;
  UpdateProfileFailure(
  {
   required this.loginFailureMessage
 }
      );
 }




class  UpdatePasswordLoading extends AuthStates { }
class   UpdatePasswordSuccess extends AuthStates {
 final String  passSuccess;
 UpdatePasswordSuccess(
     {
      required this.passSuccess,
     }
     );
}
class   UpdatePasswordFailure extends AuthStates {
 final String  passFailure;
 UpdatePasswordFailure(
     {
      required this.passFailure
     }
     );
}

class  ActivateLoading extends AuthStates { }
class  RemoveSharedState extends AuthStates { }
class   ActivateSuccess extends AuthStates {
 final String  activateSuccess;
 ActivateSuccess(
     {
      required this.activateSuccess,
     }
     );
}
class   ActivateFailure extends AuthStates {
 final String  activateFailure;
 ActivateFailure(
     {
      required this.activateFailure
     }
     );
}
class  DeviseTokenStateLoading extends AuthStates { }
class   DeviseTokenStateSuccess extends AuthStates {
 final String  message;
 DeviseTokenStateSuccess(
     {
      required this.message,
     }
     );
}
class             DeviseTokenStateFailure extends AuthStates {
 final String  message;
 DeviseTokenStateFailure(
     {
      required this.message
     }
     );
}
