// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;

Future<bool> requestNotificationPermission() async {
  final permission = html.Notification.permission;

  if (permission == 'granted') {
    return true;
  }

  if (permission == 'denied') {
    return false;
  }

  final result = await html.Notification.requestPermission();

  return result == 'granted';
}

Future<void> showLocalNotification(String title, String body) async {
  final allowed = await requestNotificationPermission();

  if (!allowed) {
    return;
  }

  html.Notification(
    title,
    body: body,
  );
}