import 'package:do_todo/Do_Todo/presentation/widgets/notification/notification_body.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.title, required this.body, required this.startTime, required this.endTime});
  final String title;
  final String body;
  final String startTime;
  final String endTime;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: NotificationBody(
          body: body,
          title: title,
          startTime: startTime,
          endTime: endTime,
        ),
      ),
    );
  }
}
