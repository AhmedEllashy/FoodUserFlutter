import 'package:food_user/data/Data_source/remote_data_source.dart';
import 'package:food_user/data/Network/failure.dart';
import 'package:food_user/data/Network/local_errors.dart';
import 'package:food_user/data/Network/network_info.dart';

abstract class Repository{
  Future signWithGoogle();
  Future signInWithEmailAndPassword(String email ,String password);
  Future signUpWithEmailAndPassword(String email ,String password);
  Future signInAnonymously();
  Future resetPassword(String email);

}
class RepositoryImplementer implements Repository{
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  RepositoryImplementer(this._networkInfo,this._remoteDataSource);
  @override
  Future signWithGoogle() async{
   if(await _networkInfo.isConnected){
    return await _remoteDataSource.signWithGoogle();
   }else{
     throw(ErrorMessages.internetError);
   }
  }

  @override
  Future signInAnonymously() async{
    if(await _networkInfo.isConnected){
      return await _remoteDataSource.signInAnonymously();
    }else{
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async{
    if(await _networkInfo.isConnected){
      return await _remoteDataSource.signInWithEmailAndPassword(email, password);
    }else{
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password) async{
    if(await _networkInfo.isConnected){
      return await _remoteDataSource.signUpWithEmailAndPassword(email, password);
    }else{
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future resetPassword(String email) async{
    if(await _networkInfo.isConnected){
      return await _remoteDataSource.resetPassword(email);
    }else{
      throw(ErrorMessages.internetError);
    }
  }

}