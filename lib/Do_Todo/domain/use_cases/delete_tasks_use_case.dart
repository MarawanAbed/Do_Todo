import 'package:do_todo/Do_Todo/domain/repositories/get_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class DeleteTasksUseCase extends UseCase<Future<void>,int>
{
  final GetTasksRepo _repo;

  DeleteTasksUseCase(this._repo);

  @override
  Future<void> call([int? parameter]) async{
    await _repo.deleteTask(parameter!);
  }
}