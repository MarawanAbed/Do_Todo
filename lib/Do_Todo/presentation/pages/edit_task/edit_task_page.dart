import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/edit_task/edit_task_body.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => getIt<EditTaskCubit>(),
        child: Scaffold(
          body: EditTaskBody(
            todoModel: todoModel,
          ),
        ),
      ),
    );
  }
}
