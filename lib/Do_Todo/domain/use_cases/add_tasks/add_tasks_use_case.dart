import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/add_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class AddTasksUseCase extends UseCase<Future<int>,TodoModel>
{
  final AddTasksRepo _repo;

  AddTasksUseCase({required AddTasksRepo repo}) : _repo = repo;
  @override
  Future<int> call([TodoModel? parameter])async {
     return await _repo.addTask(parameter!);
  }

}