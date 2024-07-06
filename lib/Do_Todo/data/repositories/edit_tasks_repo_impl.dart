import 'package:do_todo/Do_Todo/data/data_sources/edit_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/edit_tasks_repo.dart';

class EditTasksRepoImpl implements EditTasksRepo {
  final EditTasksLocalDataSource _dataSource;

  EditTasksRepoImpl({required EditTasksLocalDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<int> editTask(TodoModel task) async {
    try {
      return await _dataSource.editTask(task);
    }  catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSchedulingNotification(NotificationModel notificationModel)async {
    try {
      await _dataSource.updateSchedulingNotification(notificationModel);
    } catch (e) {
      rethrow;
    }
  }
}