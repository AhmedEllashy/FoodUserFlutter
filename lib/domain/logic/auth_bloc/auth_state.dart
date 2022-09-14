abstract class AuthState{}

class AuthInitialState extends AuthState{}
class AuthSignWithGoogleFailedState extends AuthState{
  String errorMessage;
  AuthSignWithGoogleFailedState(this.errorMessage);
}
class AuthSignWithGoogleSuccessState extends AuthState{}
class AuthSignWithGoogleLoadingState extends AuthState{}
class AuthSignUpWithGoogleLoadingState extends AuthState{}

class AuthSignInWitheEmailAndPasswordLoadingState extends AuthState{}
class AuthSignInWitheEmailAndPasswordFailedState extends AuthState{
  String errorMessage;
  AuthSignInWitheEmailAndPasswordFailedState(this.errorMessage);
}
class AuthSignInWitheEmailAndPasswordCompletedState extends AuthState{}

class AuthSignUpWitheEmailAndPasswordLoadingState extends AuthState{}
class AuthSignUpWitheEmailAndPasswordFailedState extends AuthState{
  String errorMessage;
  AuthSignUpWitheEmailAndPasswordFailedState(this.errorMessage);
}
class AuthSignUpWitheEmailAndPasswordCompletedState extends AuthState{}

class AuthSignInAnonymouslyLoadingState extends AuthState{}
class AuthSignInAnonymouslyFailedState extends AuthState{
  String errorMessage;
  AuthSignInAnonymouslyFailedState(this.errorMessage);
}
class AuthSignInAnonymouslyCompletedState extends AuthState{}