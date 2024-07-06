import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskBlocListener extends StatelessWidget {
  const AddTaskBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTasksCubit, AddTasksState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
          success: () {
            context.read<GetTasksCubit>().getTasks();
            Navigator.of(context).pop();
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
