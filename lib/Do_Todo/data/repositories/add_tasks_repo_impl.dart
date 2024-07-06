import 'package:do_todo/Do_Todo/data/data_sources/add_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/add_tasks_repo.dart';

class AddTasksRepoImpl extends AddTasksRepo {
  final AddTasksLocalDataSource _addTasksDataSource;

  AddTasksRepoImpl({required AddTasksLocalDataSource addTasksDataSource}) : _addTasksDataSource = addTasksDataSource;

  @override
  Future<int> addTask(TodoModel todoModel) async {
    try {
      return await _addTasksDataSource.addTask(todoModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> scheduleNotification(NotificationModel notificationModel)async {
    try {
      await _addTasksDataSource.scheduleNotification(notificationModel);
    } catch (e) {
      rethrow;
    }
  }
}