import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/pages/edit_task/edit_task_page.dart';
import 'package:do_todo/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomButton(
                    title: 'تم انهاء الملاحظة',
                    onPressed: () {
                      var cubit = context.read<GetTasksCubit>();
                      cubit.deleteTask(widget.todoModel.id!);
                      context.read<GetTasksCubit>().getTasks();
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'تعديل الملاحظة',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskPage(
                            todoModel: widget.todoModel,
                          ),
                        ),
                      );
                    },
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'مسح الملاحظة',
                    onPressed: () {
                      var cubit = context.read<GetTasksCubit>();
                      _showDialogConfirm(cubit).then((value) {
                        Navigator.pop(context);
                        cubit.getTasks();
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
                    title: 'اغلاق',
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
                 Row(
                   children: [
                     widget.todoModel.isChild? Text(
                        " الطفل : "+widget.todoModel.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ):Text(
                        " الموظف : "+widget.todoModel.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
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
                            '${widget.todoModel.time} ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                  const SizedBox(
                    height: 10,
                  ),
                  if(widget.todoModel.isChild)
                    Text(
                      '${widget.todoModel.amount?.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialogConfirm(GetTasksCubit cubit) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تاكيد الحذف'),
          content: const Text('هل انت متاكد من حذف الملاحظة'),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('مسح'),
              onPressed: () {
                cubit.deleteTask(widget.todoModel.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
