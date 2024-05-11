import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'package:timezone/timezone.dart' as tz;

showNotification(
    {String title = "Title Abc",
    String body = "body Message",
    int executionTimeMilliseconds = 1000}) async {
  try {
    await notificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        tz.TZDateTime.now(tz.local)
            .add(Duration(milliseconds: executionTimeMilliseconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails("channel id", "Channel name",
                priority: Priority.max, importance: Importance.high),
            iOS: DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  } catch (e, stackTrace) {
    debugPrint(
        "💥 showNotification->tryCatch Error: $e, stackTrace:$stackTrace");
  }
}
