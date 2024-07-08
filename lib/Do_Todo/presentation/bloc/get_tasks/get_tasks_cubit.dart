import 'package:do_todo/Do_Todo/data/models/todo_model.dart';

import 'package:do_todo/Do_Todo/domain/use_cases/get_tasks/get_tasks_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/use_cases/get_tasks/cancel_notification_use_case.dart';
import '../../../domain/use_cases/get_tasks/delete_tasks_use_case.dart';

part 'get_tasks_cubit.freezed.dart';
part 'get_tasks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit(this._getTasksUseCase, this._cancelNotificationUseCase, this._deleteTasksUseCase) : super(const GetTasksState.initial());

  final GetTasksUseCase _getTasksUseCase;
  final CancelNotificationUseCase _cancelNotificationUseCase ;
  final DeleteTasksUseCase _deleteTasksUseCase;
  Future<void> getTasks() async {
    emit(const GetTasksState.loading());
    try {
      final tasks = await _getTasksUseCase.call();
      emit(GetTasksState.loaded(tasks));
    } catch (e) {
      emit(GetTasksState.error(e.toString()));
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await _cancelNotificationUseCase.call(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void>deleteTask(int id) async {
    try {
      await _deleteTasksUseCase.call(id);
    } catch (e) {
      rethrow;
    }
  }
}
