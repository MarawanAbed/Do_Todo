import 'package:do_todo/Do_Todo/domain/repositories/get_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class CancelNotificationUseCase extends UseCase<Future<void>,int>
{
  final GetTasksRepo _repo;

  CancelNotificationUseCase({required GetTasksRepo repo}):_repo = repo;
  @override
  Future<void> call([int? parameter])async {
    try {
      await _repo.cancelNotification(parameter!);
    } catch (e) {
      rethrow;
    }
  }

}