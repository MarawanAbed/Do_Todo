import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/tasks_view/time_date.dart';
import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/assets/generated/assets.dart';
import '../../../../core/widgets/notes_item.dart';

class BuildNotesItem extends StatefulWidget {
  const BuildNotesItem({
    super.key,
  });


  @override
  State<BuildNotesItem> createState() => _BuildNotesItemState();
}

class _BuildNotesItemState extends State<BuildNotesItem> {
  DateTime selectedDate = DateTime.now(); // Initialize with today's date

  String convertArabicToEnglishNumbers(String input) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (int i = 0; i < arabicNumbers.length; i++) {
      input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }
    return input;
  }

  List<TodoModel> filterTasks(List<TodoModel> tasks) {
    return tasks.where((task) {
      if (task.date == null) return false; // Check for null date
      String englishDate = convertArabicToEnglishNumbers(task.date!);
      DateTime taskDate = DateFormat('yyyy-MM-dd').parse(englishDate);
      return DateFormat('yyyy-MM-dd').format(taskDate) ==
          DateFormat('yyyy-MM-dd').format(selectedDate);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (tasks) {
            var filteredTasks = filterTasks(tasks);
            return Column(
              children: [
                TimeDate(
                  selectedTime: (time) {
                    setState(() {
                      selectedDate = time;
                    });
                  },
                  initialSelectedDate: selectedDate,
                ),
                const SizedBox(
                  height: 20,
                ),
                filteredTasks.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.todo,
                              height: 200,
                              width: 200,
                            ),
                            const Text(
                              'لا يوجد ملاحظات',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          var task = filteredTasks[index];
                          return NotesItems(
                            todoModel: task,

                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
              ],
            );
          },
          error: (message) => Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}
