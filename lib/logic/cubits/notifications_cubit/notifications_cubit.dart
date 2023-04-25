// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:studying_app/data/providers/notification_provider.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsLoadingState());

  void setUpNotification() {
    NotificationProvider.setup(isScheduled: true);
    getAllNotifications();
  }

  void getAllNotifications() async {
    emit(const NotificationsLoadingState());
    List<ActiveNotification> notifications =
        await NotificationProvider.getShownNotifications();
    if (notifications.isEmpty) {
      emit(const GotNoNotificationsState());
    } else {
      emit(GotNotificationsState(notifications: notifications));
    }
  }

  void cancelNotification({
    required int id,
  }) {
    NotificationProvider.cancel(id: id);
    getAllNotifications();
  }
   void cancelAllNotification() {
    NotificationProvider.cancelAll();
    getAllNotifications();
  }

  void addNotification({
    required MyNotification notification,
    required bool scheduleDaily,
  }) async {
    emit(const NotificationsLoadingState());
    await NotificationProvider.showNotification(
      notification: notification,
      scheduleDaily: scheduleDaily,
    );
    getAllNotifications();
  }
}
