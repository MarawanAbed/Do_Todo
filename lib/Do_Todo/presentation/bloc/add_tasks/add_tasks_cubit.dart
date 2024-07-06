import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/add_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/schedule_notification_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_tasks_cubit.freezed.dart';

part 'add_tasks_state.dart';

class AddTasksCubit extends Cubit<AddTasksState> {
  AddTasksCubit(this._addTasksUseCase, this._scheduleNotificationUseCase)
      : super(const AddTasksState.initial());

  final AddTasksUseCase _addTasksUseCase;
  final ScheduleNotificationUseCase _scheduleNotificationUseCase;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Future<int> addTasks(String selectedRepeat, int color) async {
    try {
      var todo = TodoModel(
        id: null,
        title: titleController.text,
        description: descriptionController.text,
        date: dateController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        reminder: 5,
        repeat: selectedRepeat,
        color: color,
        isCompleted: 0,
      );
      var id= await _addTasksUseCase.call(todo);
      emit(const AddTasksState.success());
      return id;
    } catch (e) {
      emit(AddTasksState.error(e.toString()));
      return 0;
    }
  }

  Future<void> scheduleNotification(int id, DateTime scheduledNotification,
      String selectedRepeat, DateTime startTime, DateTime endTime,String title) async {
    try {
      var notification = NotificationModel(
        title: title,
        body: descriptionController.text,
        id: id,
        scheduledNotificationDateTime: scheduledNotification,
        repeat: selectedRepeat,
        endTime: endTime,
        startTime: startTime,
      );
      await _scheduleNotificationUseCase.call(notification);
    } catch (e) {
      emit(AddTasksState.error(e.toString()));
    }
  }
}