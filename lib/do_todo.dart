import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/pages/tasks_view/tasks_page.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DoTodo extends StatelessWidget {
  const DoTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  getIt<GetTasksCubit>(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Do Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
