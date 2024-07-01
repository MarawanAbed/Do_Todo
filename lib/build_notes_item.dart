import 'package:do_todo/generated/assets.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/notes_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildNotesItem extends StatelessWidget {
  const BuildNotesItem({super.key, required this.selectedTime});

  final DateTime selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTasksCubit, GetTasksState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (tasks) {
            return tasks.isEmpty
                ? Column(
              children: [
                SvgPicture.asset(Assets.todo),
                const SizedBox(
                  height: 20,
                ),
                const Text('No Task Available'),
              ],
            )
                : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                var task = tasks[index];
                return NotesItems(
                  todoModel: task,
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
