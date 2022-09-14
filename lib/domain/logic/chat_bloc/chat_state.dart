part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class GetChatLoadingState extends ChatState {}
class GetChatCompletedState extends ChatState {
  final List<MessageDataModel> messages;
  GetChatCompletedState(this.messages);
}
class GetChatFailedState extends ChatState {
  final String errorMessage;
  GetChatFailedState(this.errorMessage);
}


class SendMessageLoadingState extends ChatState {}
class SendMessageCompletedState extends ChatState {}
class SendMessageFailedState extends ChatState {
  final String errorMessage;
  SendMessageFailedState(this.errorMessage);
}
