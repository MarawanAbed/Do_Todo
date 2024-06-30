import 'package:do_todo/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;


  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      await _databaseHelper.insert(task);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailure(e.toString()));
    }
  }

}
