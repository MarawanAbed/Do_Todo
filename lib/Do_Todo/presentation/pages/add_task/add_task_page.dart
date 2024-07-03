import 'package:do_todo/Do_Todo/presentation/bloc/add_cubit/add_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AddTaskCubit>(
              create: (context) => AddTaskCubit(),
            ),
          ],
          child: const AddTaskBody(),
        ),
      ),
    );
  }
}