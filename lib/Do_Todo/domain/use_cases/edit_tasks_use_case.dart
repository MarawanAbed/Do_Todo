

import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/edit_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class EditTasksUseCase extends UseCase<Future<void>,TodoModel>
{
  final EditTasksRepo _repo;

  EditTasksUseCase({required EditTasksRepo repo}) : _repo = repo;
  @override
  Future<int> call([TodoModel? parameter])async {
     return await _repo.editTask(parameter!);
  }

}