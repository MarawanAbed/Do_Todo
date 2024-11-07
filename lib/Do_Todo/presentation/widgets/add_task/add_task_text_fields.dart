import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/core/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskTextFields extends StatefulWidget {
  const AddTaskTextFields({super.key,  required this.onChanged, required this.isChild});
  final VoidCallback onChanged;
  final bool isChild;
  @override
  State<AddTaskTextFields> createState() => _AddTaskTextFieldsState();
}

class _AddTaskTextFieldsState extends State<AddTaskTextFields> {
  late TextEditingController timeController;
  late TextEditingController dateController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController amountController;


  @override
  void initState() {
    var cubit=context.read<AddTasksCubit>();
    timeController = cubit.timeController;
    dateController = cubit.dateController;
    titleController = cubit.titleController;
    amountController = cubit.amountController;
    descriptionController = cubit.descriptionController;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isChild?TextFields(
          title: 'اسم الطفل',
          controller: titleController,
          hint: 'ادخل اسم الطفل',
          onChanged: widget.onChanged,
        ):TextFields(
          title: 'اسم الموظف',
          controller: titleController,
          hint: 'ادخل اسم الموظف',
          onChanged: widget.onChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'الوصف',
          controller: descriptionController,
          hint: 'ادخل الوصف',
          onChanged: widget.onChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        if(widget.isChild)
          TextFields(
            title: 'المبلغ المدفوع',
            controller: amountController,
            hint: 'ادخل المبلغ المدفوع',
            onChanged: widget.onChanged,
          ),
        const SizedBox(
          height: 20,
        ),
        TextFields(
          title: 'التاريخ',
          controller: dateController,
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
                  dateController.text =
                      DateFormat('yyyy-MM-dd','ar').format(value!);
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
        TextFields(
          title: 'الوقت',
          controller: timeController,
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
                    timeController.text =
                        value!.format(context);
                    widget.onChanged();

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
