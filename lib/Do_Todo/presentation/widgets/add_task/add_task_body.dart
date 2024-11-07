import 'package:do_todo/Do_Todo/presentation/bloc/add_tasks/add_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_bloc_listener.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/add_task/add_task_text_fields.dart';
import 'package:do_todo/core/widgets/colors_choose.dart';
import 'package:do_todo/core/widgets/task_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key, required this.isChild});

  final bool isChild;

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
        title: const Text('ازالة التغييرات'),
        content: const Text('هل تريد الخروج بدون حفظ التغييرات؟'),
        actions: [
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
                    widget.isChild
                        ? TaskHeader(
                            title: 'اضافة طفل', onBack: _handleBack, dark: dark)
                        : TaskHeader(
                            title: 'اضافة موظف',
                            onBack: _handleBack,
                            dark: dark),
                    const SizedBox(
                      height: 20,
                    ),
                    AddTaskTextFields(
                        onChanged: _onChange, isChild: widget.isChild),
                    const SizedBox(
                      height: 10,
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
                      onTap: _createTask,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: widget.isChild
                            ? Text(
                                'اضافة طفل',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            : Text(
                                'اضافة موظف',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                      ),
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
          .addTasks(
              selectedRepeat,
              selectedColor.value?.value ?? const Color(0xFFE57373).value,
              widget.isChild)
          .then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: widget.isChild
                ? Text('تمت اضافة الطفل')
                : Text('تمت اضافة الموظف'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('الرجاء ملئ الحقول'),
        ),
      );
    }
  }
}
