import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';
import 'package:do_todo/core/services/notification_services.dart';

abstract class AddTasksLocalDataSource {
  Future<int> addTask(TodoModel todoModel);

  Future<void> scheduleNotification(NotificationModel notificationModel);
}

class AddTasksLocalDataSourceImpl implements AddTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final NotificationService _notificationModel;

  AddTasksLocalDataSourceImpl(
      {required DatabaseHelper databaseHelper,
      required NotificationService notificationModel})
      : _databaseHelper = databaseHelper,
        _notificationModel = notificationModel;

  @override
  Future<int> addTask(TodoModel todoModel) async {
   return await _databaseHelper.insert(todoModel.toMap());
  }

  @override
  Future<void> scheduleNotification(NotificationModel notificationModel)async {
    await _notificationModel.scheduleNotification(
      id: notificationModel.id,
      title: notificationModel.title,
      body: notificationModel.body,
      repeat: notificationModel.repeat,
      endTime: notificationModel.endTime,
      startTime: notificationModel.startTime,
      scheduledNotificationDateTime: notificationModel.scheduledNotificationDateTime,
    );
  }
}
