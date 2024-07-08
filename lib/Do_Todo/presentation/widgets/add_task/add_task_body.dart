import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_bloc_listener.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_text_fields.dart';
import 'package:do_todo/core/helpers/helper_methods.dart';
import 'package:do_todo/core/widgets/drop_button.dart';
import 'package:do_todo/core/widgets/row_button.dart';
import 'package:do_todo/core/widgets/task_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool _hasUnsavedChanges = false;

  void _onChange() {
    setState(() {
      _hasUnsavedChanges = true;
    });
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved changes'),
        content: const Text(
            'Are you sure you want to go back? Your changes will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  void _handleBack() async {
    bool shouldPop = await _onWillPop();
    if (shouldPop) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskHeader(
                        title: 'Add Task', onBack: _handleBack, dark: dark),
                    const SizedBox(
                      height: 20,
                    ),
                    AddTaskTextFields(onChanged: _onChange),
                    Text(
                      'Repeat',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
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
                          _hasUnsavedChanges = true;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Color',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RowButton(
                      selectedColor: selectedColor,
                      onTap: _createTask,
                      title: 'Add Task',
                    ),
                    const AddTaskBlocListener(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createTask() {
    var cubit = context.read<AddTasksCubit>();
    if (_formKey.currentState!.validate()) {
      cubit
          .addTasks(selectedRepeat,
              selectedColor.value?.value ?? const Color(0xFFE57373).value)
          .then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Task added successfully'),
          ),
        );
        DateTime startDate = HelperMethods().getDateTime(
            cubit.dateController.text, cubit.startTimeController.text);
        DateTime endDate = HelperMethods().getDateTime(
            cubit.dateController.text, cubit.endTimeController.text);
        cubit.scheduleNotification(
          value,
          startDate,
          selectedRepeat,
          startDate,
          endDate,
          '${cubit.titleController.text} is about to start.',
        );
        cubit.scheduleNotification(
          value + 1,
          endDate,
          selectedRepeat,
          startDate,
          endDate,
          '${cubit.titleController.text} is about to end.',
        );
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
