import 'package:do_todo/Do_Todo/data/models/todo_model.dart';

abstract class GetTasksRepo {
  Future<List<TodoModel>> getTasks();

  Future<void>cancelNotification(int id);

  Future<void>deleteTask(int id);
}