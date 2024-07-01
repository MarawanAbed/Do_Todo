import 'dart:io';

import 'package:do_todo/bloc_observer.dart';
import 'package:do_todo/database_services.dart';
import 'package:do_todo/do_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    DatabaseHelper.instance.initDesktopDatabase();
  }
  DatabaseHelper.instance.database;
  Bloc.observer = MyBlocObserver();
  runApp(const DoTodo());
}

