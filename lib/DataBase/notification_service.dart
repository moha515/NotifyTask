import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() {
    tz.initializeTimeZones(); // Initialize the time zones
    tz.setLocalLocation(tz.getLocation(
        'America/Detroit')); // Set the local time zone. Adjust it to your local time zone.

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime date, TimeOfDay time) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final scheduledDateTime = tz.TZDateTime.from(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
      tz.local,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
