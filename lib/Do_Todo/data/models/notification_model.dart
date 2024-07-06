class NotificationModel
{
  final String title;
  final String? payload;
  final String body;
  final int id;
  final DateTime scheduledNotificationDateTime;
  final String repeat;
  final DateTime endTime;
  final DateTime startTime;


  NotificationModel({
    required this.title,
     this.payload,
    required this.body,
    required this.id,
    required this.scheduledNotificationDateTime,
    required this.repeat,
    required this.endTime,
    required this.startTime,
  });

}
