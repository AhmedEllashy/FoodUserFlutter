import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/data/Network/firebase_paths.dart';
import 'package:food_user/domain/models/user.dart';
import 'package:meta/meta.dart';

import '../../../data/Repository/repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Repository _repository;
  UserCubit(this._repository) : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  getUserData() {
    emit(GetUserDataLoadingStateState());
    _repository.getUserData().then(
        (user) => emit(GetUserDataCompletedState(user)),
        onError: (e) => emit(GetUserDataFailedState(e)));
  }

  updateUserData(String imageUrl,String email, String name, String phoneNumber) {
    emit(UpdateUserDataLoadingStateState());
    FirebaseFirestore.instance
        .collection(FirestoreConstants.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "email": email,
      "name": name,
      "phoneNumber": phoneNumber,
      "photoUrl":imageUrl,
    }, SetOptions(merge: true)).then(
            (_) => emit(UpdateUserDataCompletedState()),
            onError: (e) => emit(UpdateUserDataFailedState(e)));
  }
}
