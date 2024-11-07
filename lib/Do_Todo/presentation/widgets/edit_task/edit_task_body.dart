import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/presentation/bloc/edit_tasks/edit_task_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/edit_task/edit_task_bloc_listener.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/edit_task/edit_task_text_fields.dart';
import 'package:do_todo/core/widgets/colors_choose.dart';
import 'package:do_todo/core/widgets/row_button.dart';
import 'package:do_todo/core/widgets/task_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.todoModel.isChild?TaskHeader(
                  dark: dark,
                  title: 'تعديل بيانات الطفل',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ):TaskHeader(
                  dark: dark,
                  title: 'تعديل بيانات الموظف',
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
                  'الالوان',
                  style: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ColorsChoose(selectedColor: selectedColor),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async{
                   await _updateTask();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: widget.todoModel.isChild
                        ? Text(
                      ' تعديل بيانات الطفل',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                        : Text(
                      ' تعديل بيانات الموظف',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const EditTaskBlocListener(),
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
        title: const Text('تاكيد'),
        content: const Text('هل انت متاكد من تعديل المهمة؟'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('نعم'),
          ),
        ],
      ),
    );

    if (shouldUpdate ?? false) {
      var cubit = context.read<EditTaskCubit>();
      await cubit.editTasks(
        widget.todoModel.id!,
        selectedColor.value!.value,
        widget.todoModel.isChild,
      );
    }
  }
}
