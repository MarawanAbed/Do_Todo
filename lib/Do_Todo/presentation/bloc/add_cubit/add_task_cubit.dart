import 'package:do_todo/database_services.dart';
import 'package:do_todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddInitial());

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Future<int> addTask(String selectedRepeat,int color) async {
    emit(AddLoading());
    try {
      var task = TodoModel(
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
      return await _databaseHelper.insert(task.toMap());
    } catch (e) {
      emit(AddFailure(e.toString()));
      return 0;
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    return super.close();
  }
}
