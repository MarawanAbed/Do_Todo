import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/edit_tasks_use_case.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/update_notification_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'edit_task_cubit.freezed.dart';
part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit(this._editTasksUseCase, this._updateNotificationUseCase)
      : super(const EditTaskState.initial());

  final EditTasksUseCase _editTasksUseCase;
  final UpdateNotificationUseCase _updateNotificationUseCase;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late TextEditingController dateController;
  bool isStartTimeSelected = false;
  bool isEndTimeSelected = false;

  late TextEditingController startTimeController;

  late TextEditingController endTimeController;

  Future<int> editTasks(int id, String repeat, int color) async {
    try {
      var task = TodoModel(
        id: id,
        title: titleController.text,
        description: descriptionController.text,
        date: dateController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        reminder: 5,
        repeat: repeat,
        color: color,
        isCompleted: 0,
      );
      var updatedId = await _editTasksUseCase.call(task);

      emit(const EditTaskState.success());
      return updatedId;
    } catch (e) {
      emit(EditTaskState.error(e.toString()));
      return 0;
    }
  }

  Future<void> updateNotification( int id, String repeat) async {
    DateTime startDate = DateFormat('yyyy-MM-dd hh:mm a')
        .parse('${dateController.text} ${startTimeController.text}');
    DateTime endDate = DateFormat('yyyy-MM-dd hh:mm a')
        .parse('${dateController.text} ${endTimeController.text}');
    var startNotification = NotificationModel(
      title: '${titleController.text} is about to start.',
      body: descriptionController.text,
      id: id,
      scheduledNotificationDateTime: startDate,
      repeat: repeat,
      endTime: endDate,
      startTime: startDate,
    );
    var endNotification = NotificationModel(
      title: '${titleController.text} is about to end.',
      body: descriptionController.text,
      id: id+1,
      scheduledNotificationDateTime: endDate,
      repeat: repeat,
      endTime: endDate,
      startTime: startDate,
    );

    if(isStartTimeSelected)
    {
      print('startNotification');
      await _updateNotificationUseCase.call(startNotification);
    }
    if(isEndTimeSelected)
    {
      print('endNotification');
      await _updateNotificationUseCase.call(endNotification);
    }
  }
}
