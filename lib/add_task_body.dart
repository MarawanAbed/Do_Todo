import 'package:do_todo/add_task_cubit.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/todo_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'constant.dart';

class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key});

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  final ValueNotifier<Color?> selectedColor = ValueNotifier<Color?>(null);
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int selectedReminder = 5;
  String selectedRepeat = 'Daily';
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFields(
                  title: 'Title',
                  controller: titleController,
                  hint: 'Enter title',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFields(
                  title: 'Description',
                  controller: descriptionController,
                  hint: 'Enter description',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Enter date',
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          print(value.toString());
                          setState(() {
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(value!);
                          });
                        });
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            readOnly: true,
                            controller: startTimeController,
                            decoration: InputDecoration(
                              hintText: 'Enter start time',
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
                                      });
                                    },
                                  );
                                },
                                icon: const Icon(Icons.watch_later_outlined),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            readOnly: true,
                            controller: endTimeController,
                            decoration: InputDecoration(
                              hintText: 'Enter end time',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: selectedTime,
                                  ).then((value) {
                                    print(value?.format(context));
                                    setState(() {
                                      endTimeController.text =
                                          value!.format(context);
                                    });
                                  });
                                },
                                icon: const Icon(Icons.watch_later_outlined),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Reminder',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ReminderDropButton(
                  lists: const [
                    5,
                    10,
                    15,
                    20,
                    25,
                    30,
                  ],
                  hint: 'Select reminder',
                  selected: selectedReminder,
                  onSelected: (value) {
                    setState(() {
                      selectedReminder = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
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
                  lists: const [
                    'Daily',
                    'Weekly',
                    'Monthly',
                    'Yearly',
                  ],
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
                    Expanded(
                      flex: 2,
                      child: ValueListenableBuilder<Color?>(
                        valueListenable: selectedColor,
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 50,
                            child: BuildColorItem(
                              selectedColor: value,
                              onSelectColor: (color) {
                                selectedColor.value = color;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          var task = TodoModel(
                            title: titleController.text,
                            id: null,
                            description: descriptionController.text,
                            date: dateController.text,
                            startTime: startTimeController.text,
                            endTime: endTimeController.text,
                            reminder: selectedReminder,
                            repeat: selectedRepeat,
                            color: selectedColor.value?.value ??
                                const Color(0xFFE57373).value,
                            isCompleted: 0,
                          );
                          context
                              .read<AddTaskCubit>()
                              .addTask(task.toMap(), context)
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Task added successfully'),
                              ),
                            );
                            Navigator.pop(context);
                            context.read<GetTasksCubit>().getTasks();
                          });
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
    );
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
  });

  final String title;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class DropButton extends StatefulWidget {
  const DropButton(
      {super.key,
      required this.lists,
      required this.selected,
      required this.hint,
      required this.onSelected});

  final List<String> lists;
  final String selected;
  final String hint;
  final ValueChanged<String> onSelected;

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: Text(
        widget.hint,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.lists
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onSelected(value!);
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class ReminderDropButton extends StatefulWidget {
  const ReminderDropButton(
      {super.key,
      required this.lists,
      required this.selected,
      required this.hint,
      required this.onSelected});

  final List<int> lists;
  final int selected;
  final String hint;
  final ValueChanged<int> onSelected;

  @override
  State<ReminderDropButton> createState() => _ReminderDropButtonState();
}

class _ReminderDropButtonState extends State<ReminderDropButton> {
  int selectedValue = 5;

  @override
  void initState() {
    selectedValue = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<int>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: Text(
        widget.hint,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.lists
          .map((item) => DropdownMenuItem<int>(
                value: item,
                child: Text(
                  "$item minutes early",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onSelected(value!);
      },
      onSaved: (value) {
        selectedValue = value!;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  final Color color;
  final bool isActive;
  final Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child: isActive ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}

class BuildColorItem extends StatelessWidget {
  const BuildColorItem({
    super.key,
    required this.selectedColor,
    required this.onSelectColor,
  });

  final Color? selectedColor;
  final Function(Color) onSelectColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        itemCount: backgroundColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final color = backgroundColors[index];
          return ColorItem(
            color: color,
            isActive: color == selectedColor,
            onTap: onSelectColor,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}

class AddTaskBlocListener extends StatelessWidget {
  const AddTaskBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
