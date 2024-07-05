import 'package:do_todo/Do_Todo/presentation/bloc/add_cubit/add_task_cubit.dart';
import 'package:do_todo/core/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskTextFields extends StatefulWidget {
  const AddTaskTextFields({super.key,  required this.onChanged});
  final VoidCallback onChanged;
  @override
  State<AddTaskTextFields> createState() => _AddTaskTextFieldsState();
}

class _AddTaskTextFieldsState extends State<AddTaskTextFields> {
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController dateController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;


  @override
  void initState() {
    var cubit=BlocProvider.of<AddTaskCubit>(context);
    startTimeController = cubit.startTimeController;
    endTimeController = cubit.endTimeController;
    dateController = cubit.dateController;
    titleController = cubit.titleController;
    descriptionController = cubit.descriptionController;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFields(
          title: 'Title',
          controller: titleController,
          hint: 'Enter title',
          onChanged: widget.onChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'Description',
          controller: descriptionController,
          hint: 'Enter description',
          onChanged: widget.onChanged,

        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'Date',
          controller: dateController,
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
                  dateController.text =
                      DateFormat('yyyy-MM-dd').format(value!);
                  widget.onChanged();

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
                controller: startTimeController,
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
                          startTimeController.text =
                              value!.format(context);
                          widget.onChanged();

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
                controller: endTimeController,
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
                          endTimeController.text =
                              value!.format(context);
                          widget.onChanged();
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
