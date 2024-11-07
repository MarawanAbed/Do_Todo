import 'package:do_todo/Do_Todo/data/models/notification_model.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/edit_tasks/update_notification_use_case.dart';
import 'package:do_todo/core/helpers/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/use_cases/edit_tasks/edit_tasks_use_case.dart';

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
  late TextEditingController amountController;
  late TextEditingController timeController;


  Future<int> editTasks(int id,  int color,bool isChild) async {
    try {
      var task = TodoModel(
        id: id,
        title: titleController.text,
        description: descriptionController.text,
        date: dateController.text,
        isChild: isChild,
        time: timeController.text,
        color: color,
        amount: isChild ? double.tryParse(amountController.text) : null,
      );
      var updatedId = await _editTasksUseCase.call(task);

      emit(const EditTaskState.success());
      return updatedId;
    } catch (e) {
      emit(EditTaskState.error(e.toString()));
      return 0;
    }
  }

}
