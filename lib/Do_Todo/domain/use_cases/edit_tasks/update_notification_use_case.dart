import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/edit_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class UpdateNotificationUseCase extends UseCase<Future<void>,NotificationModel>
{
  final EditTasksRepo _repo;

  UpdateNotificationUseCase({required EditTasksRepo repo}):_repo = repo;
  @override
  Future<void> call([NotificationModel? parameter]) async{
    try {
      await _repo.updateSchedulingNotification(parameter!);
    } catch (e) {
      rethrow;
    }
  }

}