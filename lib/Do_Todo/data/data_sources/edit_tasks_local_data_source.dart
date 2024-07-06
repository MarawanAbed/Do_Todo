import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';

import '../../../core/services/notification_services.dart';

abstract class EditTasksLocalDataSource {
  Future<int> editTask(TodoModel todoModel);

  Future<void> updateSchedulingNotification(NotificationModel notificationModel);
}


class EditTasksLocalDataSourceImpl implements EditTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final NotificationService _notificationService;

  EditTasksLocalDataSourceImpl(
      {required DatabaseHelper databaseHelper,
      required NotificationService notificationService})
      : _databaseHelper = databaseHelper,
        _notificationService = notificationService;

  @override
  Future<int> editTask(TodoModel todoModel) async {
    return await _databaseHelper.update(todoModel.toMap());
  }

  @override
  Future<void> updateSchedulingNotification(NotificationModel notificationModel)async {
    await _notificationService.updateSchedulingNotification(
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