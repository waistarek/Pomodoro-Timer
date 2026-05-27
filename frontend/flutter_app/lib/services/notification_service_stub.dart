Future<bool> requestNotificationPermission() async {
  return false;
}

Future<void> showLocalNotification(String title, String body) async {
  // Fallback für Nicht-Web-Plattformen.
  // Später kann hier flutter_local_notifications für Android/iOS angebunden werden.
}