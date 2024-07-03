import 'package:do_todo/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;


  Future<int> addTask(Map<String, dynamic> task,BuildContext context) async {
    try {
      return _databaseHelper.insert(task);
    } catch (e) {
      emit(AddTaskFailure(e.toString()));
      return 0;
    }
  }

}
