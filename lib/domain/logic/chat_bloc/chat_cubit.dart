import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/Repository/repository.dart';
import '../../models/chat.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final Repository _repository;
  ChatCubit(this._repository) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  void sendMessage(String messageBody) {
    emit(SendMessageLoadingState());
    _repository.sendMessage(messageBody).then(
        (value) => emit(SendMessageCompletedState()),
        onError: (e) => emit(SendMessageFailedState(e.toString())));
  }
  //  getAllCartProducts() {
  //   emit(GetChatLoadingState());
  // try{
  //   final messages = _repository.getChatMessages();
  //   emit(GetChatCompletedState(messages.));
  // }catch(e){
  //   emit(GetChatFailedState(e.toString()));
  // }
  // }
}
