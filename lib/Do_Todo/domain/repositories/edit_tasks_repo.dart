import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';

abstract class EditTasksRepo {
  Future<int> editTask(TodoModel todoModel);

  Future<void> updateSchedulingNotification(NotificationModel notificationModel);
}