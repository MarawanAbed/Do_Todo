part of 'get_tasks_cubit.dart';


@freezed
class GetTasksState with _$GetTasksState {
  const factory GetTasksState.initial() = _Initial;


  const factory GetTasksState.loading() = Loading;

  const factory GetTasksState.loaded(List<TodoModel> tasks) = Loaded;

  const factory GetTasksState.error(String message) = Error;
}
