import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    const initializeAndroidSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _notificationsPlugin.initialize(initializeAndroidSettings,
        onDidReceiveNotificationResponse: (details) {
      if (details.input != null) {
        print(details);
      }
    });
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          message.notification!.android!.sound ?? "Channel Id",
          message.notification!.android!.sound ?? "Main Channel",
          playSound: true,
          priority: Priority.max,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> scheduleNotification(Duration duration) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _notificationsPlugin.zonedSchedule(
      id,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(duration),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
      )),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
