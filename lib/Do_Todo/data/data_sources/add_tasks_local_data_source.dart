import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';

abstract class AddTasksLocalDataSource {
  Future<int> addTask(TodoModel todoModel);

  Future<void> scheduleNotification(NotificationModel notificationModel);
}

class AddTasksLocalDataSourceImpl implements AddTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;

  AddTasksLocalDataSourceImpl(
      {required DatabaseHelper databaseHelper,
      })
      : _databaseHelper = databaseHelper;

  @override
  Future<int> addTask(TodoModel todoModel) async {
   return await _databaseHelper.insert(todoModel.toMap());
  }

  @override
  Future<void> scheduleNotification(NotificationModel notificationModel)async {

  }
}
