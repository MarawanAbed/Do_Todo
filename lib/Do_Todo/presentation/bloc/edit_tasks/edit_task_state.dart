part of 'edit_task_cubit.dart';

@freezed
class EditTaskState with _$EditTaskState {
  const factory EditTaskState.initial() = _Initial;

  const factory EditTaskState.error(String error) = Error;

  const factory EditTaskState.success() = Success;
}
