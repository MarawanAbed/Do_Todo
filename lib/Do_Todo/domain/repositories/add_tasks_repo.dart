import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';

abstract class AddTasksRepo {
  Future<int> addTask(TodoModel todoModel);

  Future<void>scheduleNotification(NotificationModel notificationModel);
}