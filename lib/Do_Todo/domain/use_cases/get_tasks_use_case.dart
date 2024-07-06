import 'package:do_todo/core/use_cases/use_cases.dart';

import '../../data/models/todo_model.dart';
import '../repositories/get_tasks_repo.dart';

class GetTasksUseCase extends UseCase<Future<List<TodoModel>>, NoParameter> {
  final GetTasksRepo _repo;

  GetTasksUseCase({required GetTasksRepo repo}) : _repo = repo;
  @override
  Future<List<TodoModel>> call([NoParameter? parameter]) async {
    return await _repo.getTasks();
  }
}