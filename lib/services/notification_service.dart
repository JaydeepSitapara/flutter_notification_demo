import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  Future<bool> requestNotificationPermission() async {
    var status = await Permission.notification.status;

    if (status.isGranted) {
      // Permission already granted
      return true;
    } else if (status.isDenied || status.isRestricted || status.isLimited) {
      // Ask for permission
      var result = await Permission.notification.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // You can prompt the user to open app settings
      await openAppSettings();
      return false;
    }

    return false;
  }

  NotificationService._privateConstructor();

  static final NotificationService _instance =
      NotificationService._privateConstructor();

  factory NotificationService() {
    return _instance;
  }

  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  final StreamController<NotificationResponse> notificationStream =
      StreamController<NotificationResponse>();

  ///initialize the notification service
  Future<void> initialize() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings darwinInitializationSettings =
          DarwinInitializationSettings();

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettings,
      );

      await notificationPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: notificationStream.add,
      );
    } catch (e) {
      print("Error initializing notification service: $e");
    }
  }

  Future<void> showNotification() async {
    try {
      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'This channel is used for heads-up notifications.',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
      );

      final DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails();

      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      notificationPlugin.show(
        1,
        "Hey, this is instant notification",
        "Good Evening.",
        notificationDetails,
      );
    } catch (e) {
      print('Error in showNotification: ${e}');
    }
  }
}
