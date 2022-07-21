import 'package:food_user/data/Network/auth_api.dart';

abstract class RemoteDataSource{
  Future signWithGoogle();
  Future signInWithEmailAndPassword(String email ,String password);
  Future signUpWithEmailAndPassword(String email ,String password);
  Future signInAnonymously();
  Future resetPassword(String email);


}
class RemoteDataSourceImplementer implements RemoteDataSource {
  final AuthApi _authApi;

  @override
  Future signWithGoogle()async{
    return await _authApi.signWithGoogle();
  }

  RemoteDataSourceImplementer(this._authApi);

  @override
  signInAnonymously()async{
   return await _authApi.signInAnonymously();
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async{
    return await _authApi.signInWithEmailAndPassword(email, password);
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password) async{
    return await _authApi.signUpWithEmailAndPassword(email, password);

  }

  @override
  Future resetPassword(email) async{
    await _authApi.resetPassword(email: email);
  }
}