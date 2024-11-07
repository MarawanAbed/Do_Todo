import 'package:device_preview/device_preview.dart';
import 'package:do_todo/do_todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/di.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/database_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();

  final prefs = await SharedPreferences.getInstance();
  final isDatabaseInitialized = prefs.getBool('isDatabaseInitialized') ?? false;

  if (!isDatabaseInitialized) {
    await getIt<DatabaseHelper>().deleteExistingDatabase();
    await getIt<DatabaseHelper>().initDatabase();
    await prefs.setBool('isDatabaseInitialized', true);
  } else {
    await getIt<DatabaseHelper>().initDatabase();
  }

  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:(context)=> DoTodo(),
    ),
  );
}
