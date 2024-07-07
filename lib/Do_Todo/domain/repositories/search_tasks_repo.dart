import 'package:do_todo/Do_Todo/data/models/todo_model.dart';

abstract class SearchTasksRepo
{
  Future<List<TodoModel>> searchTasks(String query);
}