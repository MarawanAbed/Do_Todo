import 'package:do_todo/Do_Todo/data/data_sources/get_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/get_tasks_repo.dart';

class GetTasksRepoImpl extends GetTasksRepo {
  final GetTasksLocalDataSource _getTasksLocalDataSource;

  GetTasksRepoImpl({required GetTasksLocalDataSource getTasksLocalDataSource}) : _getTasksLocalDataSource = getTasksLocalDataSource;



  @override
  Future<List<TodoModel>> getTasks() async {
    try {
      final tasks = await _getTasksLocalDataSource.getTasks();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelNotification(int id)async {
    try {
      await _getTasksLocalDataSource.cancelNotification(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(int id)async {
    try {
      await _getTasksLocalDataSource.deleteTask(id);
    } catch (e) {
      rethrow;
    }
  }
}