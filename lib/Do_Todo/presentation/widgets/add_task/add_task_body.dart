import 'package:do_todo/Do_Todo/presentation/bloc/add_cubit/add_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_bloc_listener.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_header.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_text_fields.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/colors_choose.dart';
import 'package:do_todo/core/widgets/drop_button.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../notification_services.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  final ValueNotifier<Color?> selectedColor = ValueNotifier<Color?>(null);

  int selectedReminder = 5;
  String selectedRepeat = 'Daily';
  TimeOfDay selectedTime = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddTaskHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  const AddTaskTextFields(),
                  const Text(
                    'Repeat',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropButton(
                    hint: 'Select repeat',
                    lists: const ['Daily', 'Weekly', 'Monthly', 'none'],
                    selected: selectedRepeat,
                    onSelected: (value) {
                      setState(() {
                        selectedRepeat = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Color',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ColorsChoose(selectedColor: selectedColor),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _createTask();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              'Create Task',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const AddTaskBlocListener(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createTask() {
    var cubit = BlocProvider.of<AddTaskCubit>(context);
    if (_formKey.currentState!.validate()) {
      cubit
          .addTask(selectedRepeat,
              selectedColor.value?.value ?? const Color(0xFFE57373).value)
          .then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Task added successfully'),
          ),
        );
        DateTime startDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
            '${cubit.dateController.text} ${cubit.startTimeController.text}');
        DateTime endDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
            '${cubit.dateController.text} ${cubit.endTimeController.text}');
        NotificationService().scheduleNotification(
          id: value,
          title: '${cubit.titleController.text} is about to start.',
          body: cubit.descriptionController.text,
          scheduledNotificationDateTime: startDate,
          repeat: selectedRepeat,
          endTime: endDate,
          startTime: startDate,
        );
        NotificationService().scheduleNotification(
          id: value + 1,
          title: '${cubit.titleController.text} is about to end.',
          body: cubit.descriptionController.text,
          scheduledNotificationDateTime: endDate,
          repeat: selectedRepeat,
          endTime: endDate,
          startTime: startDate,
        );
        Navigator.pop(context);
        context.read<GetTasksCubit>().getTasks();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please fill all fields'),
        ),
      );
    }
  }
}
