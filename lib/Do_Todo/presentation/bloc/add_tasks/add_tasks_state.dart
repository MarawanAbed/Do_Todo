part of 'add_tasks_cubit.dart';

@freezed
class AddTasksState with _$AddTasksState {
  const factory AddTasksState.initial() = _Initial;

  const factory AddTasksState.success() = Success;
  const factory AddTasksState.error(String error) = Error;
}
