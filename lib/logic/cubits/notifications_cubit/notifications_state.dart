part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsLoadingState extends NotificationsState {
  const NotificationsLoadingState();
}

class GotNotificationsState extends NotificationsState {
  final List<ActiveNotification> notifications;
  const GotNotificationsState({
    required this.notifications,
  });
  @override
  // TODO: implement props
  List<Object> get props => [notifications];
}

class GotNoNotificationsState extends NotificationsState {
  const GotNoNotificationsState();
}

class NewNotificationAddedState extends NotificationsState {
  const NewNotificationAddedState();
}
