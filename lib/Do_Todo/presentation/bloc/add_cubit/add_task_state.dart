part of 'add_task_cubit.dart';

@immutable
sealed class AddTaskState {}

final class AddInitial extends AddTaskState {}

final class AddLoading extends AddTaskState {}

final class AddSuccess extends AddTaskState {}

final class AddFailure extends AddTaskState {
  final String error;

  AddFailure(this.error);
}
