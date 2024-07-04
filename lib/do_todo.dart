import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DoTodo extends StatelessWidget {
  const DoTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  GetTasksCubit(),
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
