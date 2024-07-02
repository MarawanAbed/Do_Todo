import 'package:do_todo/generated/assets.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/notes_item.dart';
import 'package:do_todo/time_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BuildNotesItem extends StatefulWidget {
  const BuildNotesItem({super.key,});

  @override
  State<BuildNotesItem> createState() => _BuildNotesItemState();
}

class _BuildNotesItemState extends State<BuildNotesItem> {
  DateTime selectedDate = DateTime.now(); // Initialize with today's date

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (tasks) {
            var filteredTasks = tasks.where((task) => task.date == DateFormat('yyyy-MM-dd').format(selectedDate)).toList();
            return filteredTasks.isEmpty
                ? Center(
                    child: Column(
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
                        SvgPicture.asset(
                          Assets.todo,
                          height: 200,
                          width: 200,
                        ),
                        const Text(
                          'No Task Available',
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
                          NotesItems(
                            todoModel: task,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  );
          },
          failure: (message) => Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}
