part of 'search_tasks_cubit.dart';

@freezed
class SearchTasksState with _$SearchTasksState {
  const factory SearchTasksState.initial() = _Initial;


  const factory SearchTasksState.loaded(List<TodoModel> tasks) = Loaded;

  const factory SearchTasksState.error(String message) = Error;
}
