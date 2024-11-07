import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/core/services/database_services.dart';


abstract class GetTasksLocalDataSource {
  Future<List<TodoModel>> getTasks();
  Future<void>cancelNotification(int id);
  Future<void>deleteTask(int id);
}


class GetTasksLocalDataSourceImpl implements GetTasksLocalDataSource {
  final DatabaseHelper _databaseHelper;


  GetTasksLocalDataSourceImpl({required DatabaseHelper databaseHelper,
  })
      : _databaseHelper = databaseHelper
   ;
  @override
  Future<List<TodoModel>> getTasks() async{
     var queries=await _databaseHelper.queryAllRows();
     return queries.map((e) => TodoModel.fromMap(e)).toList();
  }

  @override
  Future<void> cancelNotification(int id)async {
  }

  @override
  Future<void> deleteTask(int id)async {
    await _databaseHelper.delete(id);
  }

}