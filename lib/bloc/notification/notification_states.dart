abstract class NotificationStates {}

class InitialState extends NotificationStates {}

class HasNotificationState extends NotificationStates {
  int notificationCount;
  HasNotificationState({required this.notificationCount});
}

class noNotification extends NotificationStates {}
