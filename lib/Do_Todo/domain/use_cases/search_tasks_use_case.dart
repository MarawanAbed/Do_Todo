import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/search_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class SearchTasksUseCase extends UseCase<Future<List<TodoModel>>,String>
{
  final SearchTasksRepo _repo;

  SearchTasksUseCase(this._repo);
  @override
  Future<List<TodoModel>> call([String? parameter])async {
    return await _repo.searchTasks(parameter!);
  }

}