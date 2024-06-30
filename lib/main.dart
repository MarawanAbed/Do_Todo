import 'package:do_todo/database_services.dart';
import 'package:do_todo/do_todo.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;
  runApp(const DoTodo());
}

