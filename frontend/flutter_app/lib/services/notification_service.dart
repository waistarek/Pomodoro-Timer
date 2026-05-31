import 'notification_service_stub.dart'
    if (dart.library.html) 'notification_service_web.dart' as platform;

class NotificationService {
  Future<bool> requestPermission() {
    return platform.requestNotificationPermission();
  }

  Future<void> showLocalInfo(String title, String body) {
    return platform.showLocalNotification(title, body);
  }
}
