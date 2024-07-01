import 'package:do_todo/todo_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database_services.dart';
part 'get_tasks_state.dart';
part 'get_tasks_cubit.freezed.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit() : super(const GetTasksState.initial());


  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;


  Future<void> getTasks() async {
    try {
      print('getTasks');
      emit(const GetTasksState.loading());
      final tasks = await _databaseHelper.queryAllRows();
      emit(GetTasksState.loaded(tasks.map((e) => TodoModel.fromMap(e)).toList()));
    } catch (e) {
      emit(GetTasksState.failure(e.toString()));
    }
  }
}
