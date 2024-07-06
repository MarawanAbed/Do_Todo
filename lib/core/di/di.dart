import 'package:do_todo/Do_Todo/data/data_sources/add_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/data_sources/edit_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/data_sources/get_tasks_local_data_source.dart';
import 'package:do_todo/Do_Todo/data/repositories/add_tasks_repo_impl.dart';
import 'package:do_todo/Do_Todo/data/repositories/edit_tasks_repo_impl.dart';
import 'package:do_todo/Do_Todo/data/repositories/get_tasks_repo_impl.dart';
import 'package:do_todo/Do_Todo/domain/repositories/add_tasks_repo.dart';
import 'package:do_todo/Do_Todo/domain/repositories/edit_tasks_repo.dart';
import 'package:do_todo/Do_Todo/domain/repositories/get_tasks_repo.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/add_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/cancel_notification_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/delete_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/edit_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/get_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/schedule_notification_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/update_notification_use_case.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/core/services/database_services.dart';
import 'package:do_todo/core/services/notification_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

void setupDi() {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  getIt.registerLazySingleton(() => notificationsPlugin);

  ///services
  getIt.registerLazySingleton<NotificationService>(
      () => NotificationService(notificationsPlugin: getIt()));
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  ///data sources
  getIt.registerLazySingleton<AddTasksLocalDataSource>(() =>
      AddTasksLocalDataSourceImpl(
          databaseHelper: getIt(), notificationModel: getIt()));
  getIt.registerLazySingleton<EditTasksLocalDataSource>(() =>
      EditTasksLocalDataSourceImpl(
          databaseHelper: getIt(), notificationService: getIt()));
  getIt.registerLazySingleton<GetTasksLocalDataSource>(() =>
      GetTasksLocalDataSourceImpl(
          databaseHelper: getIt(), notificationService: getIt()));

  /// repository
  getIt.registerLazySingleton<AddTasksRepo>(
      () => AddTasksRepoImpl(addTasksDataSource: getIt()));
  getIt.registerLazySingleton<EditTasksRepo>(
      () => EditTasksRepoImpl(dataSource: getIt()));
  getIt.registerLazySingleton<GetTasksRepo>(
      () => GetTasksRepoImpl(getTasksLocalDataSource: getIt()));

  /// use cases
  getIt.registerLazySingleton<AddTasksUseCase>(
      () => AddTasksUseCase(repo: getIt()));
  getIt.registerLazySingleton<GetTasksUseCase>(
      () => GetTasksUseCase(repo: getIt()));
  getIt.registerLazySingleton<EditTasksUseCase>(
      () => EditTasksUseCase(repo: getIt()));
  getIt.registerLazySingleton<CancelNotificationUseCase>(
      () => CancelNotificationUseCase(repo: getIt()));
  getIt.registerLazySingleton<UpdateNotificationUseCase>(
      () => UpdateNotificationUseCase(repo: getIt()));
  getIt.registerLazySingleton<ScheduleNotificationUseCase>(
      () => ScheduleNotificationUseCase(repo: getIt()));
  getIt.registerLazySingleton<DeleteTasksUseCase>(
      () => DeleteTasksUseCase(getIt()));

  ///cubit
  getIt.registerFactory(() => AddTasksCubit(getIt(), getIt()));
  getIt.registerFactory(() => GetTasksCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => EditTaskCubit(getIt(), getIt()));
}
