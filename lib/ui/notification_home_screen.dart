import 'package:flutter/material.dart';
import 'package:notification_demo/services/notification_service.dart';

class NotificationHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {

                await NotificationService().showNotification();

              },
              child: Text(
                'Show Notification',
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Schedule Notification',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }




}
