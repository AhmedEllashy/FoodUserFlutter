import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/Repository/repository.dart';
import '../../models/notification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final Repository _repository;
  NotificationCubit(this._repository) : super(GetNotificationLoadingState());

  static NotificationCubit get(context) =>
      BlocProvider.of<NotificationCubit>(context);

  void getAllNotifications() {
    _repository.getUserNotifications().then((notifications) {
      emit(GetNotificationCompletedState(notifications));
    }, onError: (e) => emit(GetNotificationFailedState(e.toString())));
  }
}
