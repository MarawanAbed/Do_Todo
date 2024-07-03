import 'package:do_todo/Do_Todo/presentation/bloc/add_cubit/add_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskBlocListener extends StatelessWidget {
  const AddTaskBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is AddFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
