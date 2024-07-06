import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTaskBlocListener extends StatelessWidget {
  const EditTaskBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTaskCubit, EditTaskState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Task Updated Successfully'),
              ),
            );
            context.read<GetTasksCubit>().getTasks();
            Navigator.pop(context);
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(error),
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
