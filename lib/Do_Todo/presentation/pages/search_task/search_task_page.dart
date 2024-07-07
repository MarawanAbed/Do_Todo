import 'package:do_todo/Do_Todo/presentation/bloc/search_tasks/search_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/search_task/search_task_body.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTaskPage extends StatelessWidget {
  const SearchTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt<SearchTasksCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: dark ? Colors.black : Colors.white,
          title: Text(
            'Search Tasks',
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: const SearchTaskBody(),
      ),
    );
  }
}
