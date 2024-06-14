import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializeSetting = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializeSetting,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'finnhub_project/flutter_local_notifications',
          'notification_send_port',
          channelDescription: 'a channel to send local notifications',
          importance: Importance.high,
          priority: Priority.high),
    );
  }

  Future<void> showNotifcation(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }
}
