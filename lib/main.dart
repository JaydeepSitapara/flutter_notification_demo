import 'package:flutter/material.dart';
import 'package:notification_demo/services/notification_service.dart';
import 'package:notification_demo/ui/notification_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().requestNotificationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotificationHomeScreen(),
    );
  }
}
