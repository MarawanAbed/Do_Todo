import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/theme/themes_cubit.dart';
import 'package:do_todo/core/services/notification_services.dart';
import 'package:do_todo/do_todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/di/di.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/database_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  await getIt<NotificationService>().initNotification();
  tz.initializeTimeZones();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    getIt<DatabaseHelper>().initDesktopDatabase();
  }
  final darkThemeCubit = getIt<DarkThemeCubit>();
  await darkThemeCubit.getSavedTheme();
  getIt<DatabaseHelper>().initDatabase();
  Bloc.observer = MyBlocObserver();
  runApp(DoTodo(
    darkThemeCubit: darkThemeCubit,
  ));
}
