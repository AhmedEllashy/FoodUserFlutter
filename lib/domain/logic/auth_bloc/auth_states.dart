abstract class AuthStates{}

class AuthInitialState extends AuthStates{}
class AuthSignWithGoogleFailedState extends AuthStates{
  String errorMessage;
  AuthSignWithGoogleFailedState(this.errorMessage);
}
class AuthSignWithGoogleSuccessState extends AuthStates{}
class AuthSignWithGoogleLoadingState extends AuthStates{}
class AuthSignUpWithGoogleLoadingState extends AuthStates{}

class AuthSignInWitheEmailAndPasswordLoadingState extends AuthStates{}
class AuthSignInWitheEmailAndPasswordFailedState extends AuthStates{
  String errorMessage;
  AuthSignInWitheEmailAndPasswordFailedState(this.errorMessage);
}
class AuthSignInWitheEmailAndPasswordCompletedState extends AuthStates{}

class AuthSignUpWitheEmailAndPasswordLoadingState extends AuthStates{}
class AuthSignUpWitheEmailAndPasswordFailedState extends AuthStates{
  String errorMessage;
  AuthSignUpWitheEmailAndPasswordFailedState(this.errorMessage);
}
class AuthSignUpWitheEmailAndPasswordCompletedState extends AuthStates{}

class AuthSignInAnonymouslyLoadingState extends AuthStates{}
class AuthSignInAnonymouslyFailedState extends AuthStates{
  String errorMessage;
  AuthSignInAnonymouslyFailedState(this.errorMessage);
}
class AuthSignInAnonymouslyCompletedState extends AuthStates{}