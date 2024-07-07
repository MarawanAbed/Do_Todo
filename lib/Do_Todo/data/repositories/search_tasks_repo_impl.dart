import 'package:do_todo/Do_Todo/data/data_sources/search_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/search_tasks_repo.dart';

class SearchTasksRepoImpl extends SearchTasksRepo
{
  final SearchTasksLocalDataSource _dataSource;

  SearchTasksRepoImpl(this._dataSource);
  @override
  Future<List<TodoModel>> searchTasks(String query)async {
    return await _dataSource.searchTasks(query);
  }
  
}