part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationCompletedState extends NotificationState {
  final List<NotificationDataModel> notifications;
  GetNotificationCompletedState(this.notifications);
}

class GetNotificationLoadingState extends NotificationState {}
class GetNotificationFailedState extends NotificationState {
  final String error;
  GetNotificationFailedState(this.error);
}