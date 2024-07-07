import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';

abstract class SearchTasksLocalDataSource {
  Future<List<TodoModel>> searchTasks(String query);
}

class SearchTasksLocalDataSourceImpl extends SearchTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;

  SearchTasksLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<List<TodoModel>> searchTasks(String query) async {
    var search = await _databaseHelper.searchTasks(query);
    return search.map((e) => TodoModel.fromMap(e)).toList();
  }
}
