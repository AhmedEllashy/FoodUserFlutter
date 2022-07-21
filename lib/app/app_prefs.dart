import 'package:shared_preferences/shared_preferences.dart';

const String userLoggedInKey = 'UserLoggedInKey';
const String onBoardingKey = 'OnBoardingKey';

class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<void> setUserLoggedIn()async{
    _sharedPreferences.setBool(userLoggedInKey, true);
  }
  Future<bool> getUserLoggedIn()async{
    return  _sharedPreferences.getBool(userLoggedInKey) ?? false;
  }
  Future<void> setOnBoardingWatched()async{
    _sharedPreferences.setBool(onBoardingKey, true);
  }
  Future<bool> getOnBoardingWatched()async{
    return  _sharedPreferences.getBool(onBoardingKey) ?? false;
  }
}