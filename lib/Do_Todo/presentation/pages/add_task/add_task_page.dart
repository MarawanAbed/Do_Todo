import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_body.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key, required this.isChild});
  final bool isChild;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddTasksCubit>(),
      child:  Scaffold(
        body: AddTaskBody(
          isChild: isChild,
        ),
      ),
    );
  }
}
