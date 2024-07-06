import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/core/widgets/text_fields.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditTaskTextFields extends StatefulWidget {
  const EditTaskTextFields({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  State<EditTaskTextFields> createState() => _EditTaskTextFieldsState();
}

class _EditTaskTextFieldsState extends State<EditTaskTextFields> {
  @override
  void initState() {
    var cubit = context.read<EditTaskCubit>();
    cubit.startTimeController =
        TextEditingController(text: widget.todoModel.startTime);
    cubit.endTimeController =
        TextEditingController(text: widget.todoModel.endTime);
    cubit.dateController = TextEditingController(text: widget.todoModel.date);
    cubit.titleController = TextEditingController(text: widget.todoModel.title);
    cubit.descriptionController =
        TextEditingController(text: widget.todoModel.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EditTaskCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFields(
          title: 'Title',
          controller: cubit.titleController,
          hint: 'Enter title',
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'Description',
          controller: cubit.descriptionController,
          hint: 'Enter description',
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'Date',
          controller: cubit.dateController,
          hint: 'Enter date',
          readable: true,
          suffixIcon: IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
              ).then((value) {
                print(value.toString());
                setState(() {
                  cubit.dateController.text =
                      DateFormat('yyyy-MM-dd').format(value!);
                });
              });
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: TextFields(
                title: 'Start Time',
                controller: cubit.startTimeController,
                hint: 'Enter start time',
                readable: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then(
                      (value) {
                        print(value?.format(context));
                        setState(() {
                          cubit.startTimeController.text =
                              value!.format(context);
                          cubit.isStartTimeSelected = true;
                        });
                      },
                    );
                  },
                  icon: const Icon(Icons.watch_later_outlined),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFields(
                title: 'End Time',
                controller: cubit.endTimeController,
                hint: 'Enter end time',
                readable: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then(
                      (value) {
                        print(value?.format(context));
                        setState(() {
                          cubit.endTimeController.text = value!.format(context);
                          cubit.isEndTimeSelected = true;
                        });
                      },
                    );
                  },
                  icon: const Icon(Icons.watch_later_outlined),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
