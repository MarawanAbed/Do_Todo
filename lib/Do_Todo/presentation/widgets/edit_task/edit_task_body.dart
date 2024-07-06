import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/edit_task/edit_task_bloc_listener.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/edit_task/edit_task_text_fields.dart';
import 'package:do_todo/core/widgets/task_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/colors_choose.dart';
import '../../../../core/widgets/drop_button.dart';

class EditTaskBody extends StatefulWidget {
  const EditTaskBody({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  State<EditTaskBody> createState() => _EditTaskBodyState();
}

class _EditTaskBodyState extends State<EditTaskBody> {
  late ValueNotifier<Color?> selectedColor;
  late String selectedRepeat;


  @override
  void initState() {
    selectedColor = ValueNotifier<Color?>(Color(widget.todoModel.color));
    selectedRepeat = widget.todoModel.repeat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dark=Theme.of(context).brightness==Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskHeader(
                  dark: true,
                  title: 'Edit Task',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                EditTaskTextFields(
                  todoModel: widget.todoModel,
                ),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  'Repeat',
                  style: TextStyle(
                    color: dark?Colors.white:Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropButton(
                  hint: selectedRepeat,
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
                 Text(
                  'Color',
                  style: TextStyle(
                    color: dark?Colors.white:Colors.black,
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
                          _updateTask();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            'Edit Task',
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
                    const EditTaskBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _updateTask() async {
    final shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to edit this task?'),
        actions: <Widget>[
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

    if (shouldUpdate ?? false) {
      var cubit = context.read<EditTaskCubit>();
      await cubit.editTasks(
        widget.todoModel.id!,
        selectedRepeat,
        selectedColor.value!.value,
      );
      await cubit.updateNotification(widget.todoModel.id!, selectedRepeat);
    }
  }
}
