import 'package:do_todo/custom_button.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/notification_services.dart';
import 'package:do_todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database_services.dart';

class NotesItems extends StatefulWidget {
  const NotesItems({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  @override
  State<NotesItems> createState() => _NotesItemsState();
}

class _NotesItemsState extends State<NotesItems> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(30),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  CustomButton(
                    title: 'Task Completed',
                    onPressed: () {
                      print(widget.todoModel.id!);
                      _databaseHelper.delete(widget.todoModel.id!);
                      NotificationService().cancelNotification(widget.todoModel.id!);
                      NotificationService().cancelNotification(widget.todoModel.id!+1);
                      context.read<GetTasksCubit>().getTasks();
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Edit Task',
                    onPressed: () {},
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Delete Task',
                    onPressed: () {
                      _showDialogConfirm().then((value) {
                        NotificationService().cancelNotification(widget.todoModel.id!);
                        NotificationService().cancelNotification(widget.todoModel.id!+1);
                        Navigator.pop(context);
                        context.read<GetTasksCubit>().getTasks();
                      });
                    },
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Close',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(widget.todoModel.color),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todoModel.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.todoModel.startTime} - ${widget.todoModel.endTime}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.todoModel.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: 1,
              color: Colors.white,
            ),
            Transform.rotate(
              angle: 3.14 / 0.67,
              child: const Text(
                'TODO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialogConfirm() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _databaseHelper.delete(widget.todoModel.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
