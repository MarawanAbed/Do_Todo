import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/theme/themes_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/pages/tasks_view/tasks_page.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:do_todo/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DoTodo extends StatelessWidget {
  const DoTodo({super.key, required this.darkThemeCubit});

  final DarkThemeCubit darkThemeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GetTasksCubit>(),
        ),
        BlocProvider.value(
          value: darkThemeCubit,
        ),
      ],
      child: BlocBuilder<DarkThemeCubit, DarkThemeState>(
        buildWhen: (previous, current) => previous.isDark != current.isDark,
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Do Todo',
            theme: Themes.lightThemeData(context),
            darkTheme: Themes.darkThemeData(context),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
