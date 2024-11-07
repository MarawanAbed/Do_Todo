import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';


abstract class EditTasksLocalDataSource {
  Future<int> editTask(TodoModel todoModel);

  Future<void> updateSchedulingNotification(NotificationModel notificationModel);
}


class EditTasksLocalDataSourceImpl implements EditTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;

  EditTasksLocalDataSourceImpl(
      {required DatabaseHelper databaseHelper,
     })
      : _databaseHelper = databaseHelper
       ;

  @override
  Future<int> editTask(TodoModel todoModel) async {
    return await _databaseHelper.update(todoModel.toMap());
  }

  @override
  Future<void> updateSchedulingNotification(NotificationModel notificationModel)async {

  }
}