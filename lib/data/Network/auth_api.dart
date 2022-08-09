import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class AuthApi {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  late UserCredential user;

  Future signWithGoogle() async {
try{
  GoogleSignInAccount? pickedUser = await googleSignIn.signIn();
  if (pickedUser == null) {
    return;
  }
  final googleAuth = await pickedUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  UserCredential userCredential =
  await _auth.signInWithCredential(credential);


  return userCredential;
}on FirebaseAuthException catch(e){
  throw(e.message.toString());
}
  }
  Future signUpWithEmailAndPassword(String email ,String password)async{
try{
  UserCredential user =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return user;
} on FirebaseAuthException catch(e){
    throw(e.message.toString());
    }
  }
  Future signInWithEmailAndPassword(String email ,String password)async{
   try {
     UserCredential user = await _auth.signInWithEmailAndPassword(
         email: email, password: password);
     return user;
   } on FirebaseAuthException catch(e){
    throw(e.message.toString());
    }
  }

  Future signInAnonymously()async{
    try{
      UserCredential user =  await _auth.signInAnonymously();
      return user;
    } on FirebaseAuthException catch(e){
    throw(e.message.toString());
    }
  }
  Future resetPassword({required String email}) async {
    try{
      await _auth
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e){
    throw(e.message.toString());
    }
  }
}
