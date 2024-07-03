import 'dart:io';
import 'package:do_todo/bloc_observer.dart';
import 'package:do_todo/database_services.dart';
import 'package:do_todo/do_todo.dart';
import 'package:do_todo/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  tz.initializeTimeZones();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    DatabaseHelper.instance.initDesktopDatabase();
  }
  DatabaseHelper.instance.database;

  Bloc.observer = MyBlocObserver();
  runApp(const DoTodo());
}

