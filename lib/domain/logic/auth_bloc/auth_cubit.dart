import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/app/app.dart';
import 'package:food_user/data/Repository/repository.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';

import '../../../app/app_prefs.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository _repository;
  final AppPreferences _appPreferences;
  AuthCubit(this._repository,this._appPreferences) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);



  Future signInWithGoogle() async {
    emit(AuthSignWithGoogleLoadingState());

      try {
        final UserCredential userCredential =
            await _repository.signWithGoogle();
        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (user.exists) {
          _appPreferences.setUserLoggedIn();
          navigatorKey.currentState!.pushReplacementNamed(AppRoutes.mainRoute);
          emit(AuthSignWithGoogleSuccessState());
        } else {
          emit(AuthSignWithGoogleFailedState(AppStrings.userSignInError));
        }
      } catch (e) {
        emit(AuthSignWithGoogleFailedState(e.toString()));
      }

  }
  Future signUpWithGoogle() async {
    emit(AuthSignUpWithGoogleLoadingState());

      try {
        final UserCredential userCredential =
            await _repository.signWithGoogle();
        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        if (user.exists) {
          emit(AuthSignWithGoogleFailedState(AppStrings.userSignUpError));
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'uid': userCredential.user?.uid,
            'email': userCredential.user?.email,
            'name': userCredential.user?.displayName,
            'photoUrl': userCredential.user?.photoURL,
            'date': DateTime.now(),
            "favourite":[],
            "addresses":[],
            "defaultAddress":"",
            'status': 'online',
            'token' : getDeviceToken(),
          });
          _appPreferences.setUserLoggedIn();
          emit(AuthSignWithGoogleSuccessState());
          navigatorKey.currentState!.pushReplacementNamed(AppRoutes.mainRoute);
        }
      } catch (e) {
        emit(AuthSignWithGoogleFailedState(e.toString()));
      }
  }
  Future signInWithEmailAndPassword(String email ,String password)async{
    emit(AuthSignInWitheEmailAndPasswordLoadingState());
    try{
      final userCredential = await _repository.signInWithEmailAndPassword(email, password);
      emit(AuthSignInWitheEmailAndPasswordCompletedState());
      _appPreferences.setUserLoggedIn();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'token': getDeviceToken(),
      });

    }catch(e){
      emit(AuthSignInWitheEmailAndPasswordFailedState(e.toString()));
    }

  }
  Future signUpWithEmailAndPassword(String email ,String password,String phoneNumber)async{
    emit(AuthSignUpWitheEmailAndPasswordLoadingState());
      try{
        UserCredential userCredential = await _repository.signUpWithEmailAndPassword(email, password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'uid': userCredential.user?.uid,
          'email': email,
          "name":"",
          'password':password,
          'phoneNumber':phoneNumber,
          'photoUrl': '',
          'date': DateTime.now(),
          "favourite":[],
          "addresses":[],
          "defaultAddress":"",
          'token': await getDeviceToken(),
          'status': 'online',
        });

        emit(AuthSignUpWitheEmailAndPasswordCompletedState());
        _appPreferences.setUserLoggedIn();

      }catch(e){
        emit(AuthSignUpWitheEmailAndPasswordFailedState(e.toString()));
      }

  }
  Future signInAnonymously()async{
     try{
       await _repository.signInAnonymously();
       emit(AuthSignInAnonymouslyCompletedState());
     }catch(e){
       emit(AuthSignInAnonymouslyFailedState(e.toString()));

     }
   }


  Future restPassword(String email)async{
    try{ //todo the func doesn't work
 await _repository.resetPassword(email);
    }on FirebaseAuthException catch(e){

    }
  }

  Future<String?> getDeviceToken()async{
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint(token);
  return token;
  }

}
