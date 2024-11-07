import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/pages/tasks_view/tasks_page.dart';
import 'package:do_todo/core/di/di.dart';
import 'package:do_todo/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class DoTodo extends StatelessWidget {
  const DoTodo({super.key, });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GetTasksCubit>(),
        ),

      ],
      child:MaterialApp(
        navigatorKey: navigatorKey,
        locale: const Locale('ar', ''), // Set locale to Arabic
        supportedLocales: const [
          Locale('ar', ''), // Only support Arabic
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Do Todo',
        theme: Themes.lightThemeData(context),
        darkTheme: Themes.darkThemeData(context),
        themeMode:  ThemeMode.light,
        home: const HomePage(),
      ),
    );
  }
}
