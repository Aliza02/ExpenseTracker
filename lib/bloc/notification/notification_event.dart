abstract class NotificationEvents {}

class HasNotification extends NotificationEvents {
  int notificationCount;
  HasNotification({required this.notificationCount});
}

class ClearNotification extends NotificationEvents {}
