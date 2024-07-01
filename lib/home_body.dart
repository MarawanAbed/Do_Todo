import 'package:do_todo/build_notes_item.dart';
import 'package:do_todo/custom_app_bar.dart';
import 'package:do_todo/get_tasks_cubit.dart';
import 'package:do_todo/header.dart';
import 'package:do_todo/time_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    context.read<GetTasksCubit>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const SizedBox(
                  height: 20,
                ),
                const Header(),
                const SizedBox(
                  height: 20,
                ),
                TimeDate(
                  selectedTime: (time) {
                    setState(() {
                      selectedTime = time;
                      print(selectedTime);
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BuildNotesItem(
                  selectedTime: selectedTime,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
