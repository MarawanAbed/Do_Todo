import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/domain/repositories/add_tasks_repo.dart';
import 'package:do_todo/core/use_cases/use_cases.dart';

class ScheduleNotificationUseCase extends UseCase<Future<void>,NotificationModel>
{
  final AddTasksRepo _repo;

  ScheduleNotificationUseCase({required AddTasksRepo repo}):_repo = repo;
  @override
  Future<void> call([NotificationModel? parameter])async {
    try {
      await _repo.scheduleNotification(parameter!);
    } catch (e) {
      rethrow;
    }
  }

}