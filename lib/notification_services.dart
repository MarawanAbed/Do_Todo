import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'Do_Todo/presentation/pages/notification/notification_page.dart';
import 'do_todo.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          if (notificationResponse.payload != null) {
            final payloadData = jsonDecode(notificationResponse.payload!);
            List<String> keywords = ['is about to end.', 'is about to start.'];
            // Filter the title
            String filteredTitle = filterTitle(payloadData['title'], keywords);

            String body = payloadData['body'];
            String startTime = payloadData['formattedStartTime'];
            String endTime = payloadData['formattedEndTime'];

            navigatorKey.currentState?.push(MaterialPageRoute(
              builder: (context) =>
                  NotificationPage(
                    title: filteredTitle, // Use the filtered title
                    body: body,
                    startTime: startTime,
                    endTime: endTime,
                  ),
            ));
          }
        });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification({
    required int id,
    String? title,
    String? body,
    required String repeat,
    required DateTime scheduledNotificationDateTime,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    String formattedStartTime = startTime.toIso8601String();
    String formattedEndTime = endTime.toIso8601String();
    print('scheduleNotification $id');
    String payload = jsonEncode({
      'title': title,
      'body': body,
      'formattedStartTime': formattedStartTime,
      'formattedEndTime': formattedEndTime,
    });

    var androidDetails = const AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max);
    var iOSDetails = const DarwinNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);
    if (repeat == 'Daily') {
      return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        payload: payload,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else if (repeat == 'Weekly') {
      return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        payload: payload,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    } else if (repeat == 'Monthly') {
      return notificationsPlugin.zonedSchedule(
        id,
        title,
        payload: payload,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );
    } else {
      return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        payload: payload,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelNotification(int id) async {
    print('cancelNotification $id');
    await notificationsPlugin.cancel(id);
    print('cancelNotification done $id');
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }

  Future<void> updateSchedulingNotification({required int id,
    String? title,
    String? body,
    String? payLoad,
    required String repeat,
    required DateTime scheduledNotificationDateTime,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await cancelNotification(id);
    await scheduleNotification(
        id: id,
        repeat: repeat,
        title: title,
        body: body,
        scheduledNotificationDateTime: scheduledNotificationDateTime,
        startTime:startTime,
        endTime:endTime
    );
  }
}

String filterTitle(String fullTitle, List<String> keywords) {
  String filteredTitle = fullTitle;
  for (String keyword in keywords) {
    if (filteredTitle.contains(keyword)) {
      filteredTitle = filteredTitle.replaceAll(keyword, '').trim();
    }
  }
  return filteredTitle;
}