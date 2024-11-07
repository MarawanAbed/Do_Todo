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
    cubit.dateController = TextEditingController(text: widget.todoModel.date);
    cubit.titleController = TextEditingController(text: widget.todoModel.title);
    cubit.descriptionController = TextEditingController(text: widget.todoModel.description);
    cubit.amountController= TextEditingController(text: widget.todoModel.amount.toString());
    cubit.timeController= TextEditingController(text: widget.todoModel.time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EditTaskCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.todoModel.isChild?TextFields(
          title: 'اسم الطفل',
          controller: cubit.titleController,
          hint: 'ادخل اسم الطفل',
        ):TextFields(
          title: 'اسم الموظف',
          controller: cubit.titleController,
          hint: 'ادخل اسم الموظف',
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'الوصف',
          controller: cubit.descriptionController,
          hint: 'ادخل الوصف',
        ),
        const SizedBox(
          height: 20,
        ),
        if(widget.todoModel.isChild)
          TextFields(
            title: 'المبلغ المدفوع',
            controller: cubit.amountController,
            hint: 'ادخل المبلغ المدفوع',
          ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'التاريخ',
          controller: cubit.dateController,
          hint: 'ادخل التاريخ',
          readable: true,
          suffixIcon: IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime(2024,9,1),
                firstDate: DateTime(2024,9,1),
                lastDate: DateTime(2029),
              ).then((value) {
                print(value.toString());
                setState(() {
                  cubit.dateController.text =
                      DateFormat('yyyy-MM-dd','ar').format(value!);
                });
              });
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'الوقت',
          controller: cubit.timeController,
          hint: 'ادخل الوقت',
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
                    cubit.timeController.text =
                        value!.format(context);

                  });
                },
              );
            },
            icon: const Icon(Icons.watch_later_outlined),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
